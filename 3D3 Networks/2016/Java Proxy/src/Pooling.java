import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.URI;

public class Pooling extends Thread {
	private Socket clientSocket;

	public Pooling(Socket clientSocket) {
		this.clientSocket = clientSocket;
	}

	@Override
	public void run() {
		outside: try {
			BufferedReader fromClient = new BufferedReader(
					new InputStreamReader(clientSocket.getInputStream()));
			DataOutputStream toClient = new DataOutputStream(
					clientSocket.getOutputStream());

			Socket server = new Socket();

			String host = null;
			int port = -1;

			// Read the request line
			String line = fromClient.readLine();
			String firstLine = line;

			if (line == null) {
				break outside;
			}

			// Prints first line
			String[] tokens = line.split(" ");
			System.out.println(">>> " + tokens[0] + " " + tokens[1]);

			// Extract host and port
			StringBuffer part = new StringBuffer();
			boolean foundHost = false;
			while (!foundHost && line != null && !line.equals("")) {
				if (line.contains("keep-alive")) {
					line = line.replaceAll("keep-alive", "close");
				}
				if (line.contains("HTTP/1.1")) {
					line = line.replaceAll("HTTP/1.1", "HTTP/1.0");
				}

				if (line.toLowerCase().startsWith("host")) {
					foundHost = true;
					String[] hostTokens = line.split(":");
					host = hostTokens[1].trim();
					if (hostTokens.length > 2) {
						port = Integer.parseInt(hostTokens[2]);
					} else {
						URI uri = new URI(firstLine.split(" ")[1]);
						port = uri.getPort();
					}
				}

				if (line.toLowerCase().startsWith("get")) {
					line = line.replaceFirst("http://", "");
					String rep = line.split(" ")[1]
							.substring(line.split(" ")[1].indexOf("/"));
					line = line.replaceAll(line.split(" ")[1], rep);
				}

				part.append(line + "\n");
				line = fromClient.readLine();
			}

			// HTTP CONNECT Tunneling
			if (tokens[0].equals("CONNECT")) {
				if (port == -1) {
					port = Helpers.CONNECT_PORT;
				}

				// Connect to server
				try {
					server.connect(new InetSocketAddress(host, port));
				} catch (Exception e) {
					// Fails to connect to server
					toClient.write("HTTP/1.0 502 Bad Gateway".getBytes());
					toClient.write("\r\n\r\n".getBytes());
					e.printStackTrace();
				}

				// Successfully connected to server
				try {
					toClient.write("HTTP/1.0 200 OK".getBytes());
					toClient.write("\r\n\r\n".getBytes());
				} catch (Exception e) {
				}

				final byte[] request = new byte[4096];
				byte[] response = new byte[4096];

				final InputStream from_c = clientSocket.getInputStream();
				final OutputStream to_c = clientSocket.getOutputStream();

				final InputStream from_s = server.getInputStream();
				final OutputStream to_s = server.getOutputStream();

				Thread clientThread = new Thread() {
					public void run() {
						int bytesRead;
						try {
							while ((bytesRead = from_c.read(request)) != -1) {
								to_s.write(request, 0, bytesRead);
								to_s.flush();
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				};
				clientThread.start();

				int bytesRead2;
				try {
					while ((bytesRead2 = from_s.read(response)) != -1) {
						to_c.write(response, 0, bytesRead2);
						to_c.flush();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				server.close();
				clientSocket.close();

				break outside;
			}

			// --------------------------------------------------------------------------------------
			// Non-CONNECT HTTP requests
			// look at content length header

			if (port == -1) {
				port = Helpers.NON_CONNECT_PORT;
			}

			if (Blacklist.checkList(host)) {
				Blacklist.blockWebsite(host, clientSocket);
				server.close();
				clientSocket.close();
				break outside;
			} else {
				// Forward request
				server.connect(new InetSocketAddress(host, port));
				PrintWriter toServer = new PrintWriter(
						server.getOutputStream(), true);
				toServer.print(part.toString());

				// Write the rest of headers
				while (line != null && !line.equals("")) {
					if (line.contains("keep-alive")) {
						line = line.replaceAll("keep-alive", "close");
					}
					if (line.contains("HTTP/1.1")) {
						line = line.replaceAll("HTTP/1.1", "HTTP/1.0");
					}

					toServer.println(line);
					line = fromClient.readLine();
				}

				toServer.println("\r\n\r\n");

				// Get response from server
				// Forward to client
				InputStream fromServer = server.getInputStream();
				int bytesRead = 0;
				byte[] response = new byte[4096];
				while ((bytesRead = fromServer.read(response)) != -1) {
					toClient.write(response, 0, bytesRead);
					toClient.flush();
				}
				
				Caching.logHistory(host);
				Caching.saveFile(response.toString(), host);
				server.close();
				clientSocket.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}