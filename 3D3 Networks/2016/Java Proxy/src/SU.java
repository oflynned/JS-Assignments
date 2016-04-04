import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Scanner;

public class SU extends Thread {
	
	private static final String BLACKLIST_PATH = "./admin/Blacklist.txt";
	
	public SU() {
		suPrint("Superuser module invoked.");
		suPrint("Type su --<cmd> to invoke an administrator command.");
	}
	
	@Override
	public void run() {
		try {
			String input;
			String[] parts;
			Scanner scannerInput = new Scanner(System.in);
			while(scannerInput.hasNext()) {
				input = scannerInput.nextLine();
				parts = input.split(" ");
				if(parts[0].equals("su")) {
					if(parts[1].equals("--help")) {
						suPrint("\nHelp invoked!");
						suPrint("Commands for Superuser mode:");
						suPrint("--help -> invokes list of commands");
						suPrint("--block <website> -> adds website to blacklist");
						suPrint("--list -> lists the currently blacklisted websites");
						suPrint("--unblock <website> -> removes website from blacklist");
					} else if(parts[1].equals("--block")) {
						if(!parts[2].equals(null)) {
							addToBlacklist(parts[2]);
							suPrint(parts[2] + " has been added to the blacklist!");	
						} else {
							suPrint("Website cannot be null!");
						}
					} else if(parts[1].equals("--list")){
						suPrint("Blacklisted websites:");
						for(String website : blacklistedWebsites()) {
							suPrint(website);
						}
					} else if(parts[1].equals("--unblock")) {
						if(!parts[2].equals(null)) {
							suPrint(parts[2] + " has been removed from the blacklist!");
						} else {
							suPrint("Website cannot be null!");
						}
					} else {
						suPrint("Commands must be prefixed with \"--\"!");
					}
				} else {
					suPrint("Must append \"su\" to the start of the command! su <cmd> <parameters>");
				}
			}
			scannerInput.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private void addToBlacklist(String url) {
		try {
			Path filePath = Paths.get(BLACKLIST_PATH);
			Files.write(filePath, url.getBytes(), StandardOpenOption.APPEND);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private String[] blacklistedWebsites() {
		ArrayList<String> blacklist = new ArrayList<String>();
		
		try {
			File file = new File(BLACKLIST_PATH);
			Scanner scanner = new Scanner(file);
			while(scanner.hasNext()) {
				blacklist.add(scanner.next());
			}
			scanner.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		String[] blacklistedWebsites = new String[blacklist.size()];
		for(int i=0; i < blacklist.size(); i++) {
			blacklistedWebsites[i] = blacklist.get(i);
		}
		
		return blacklistedWebsites;
	}
	
	private static void suPrint(String phrase) {
		System.out.println("SU: " + phrase);
	}

}
