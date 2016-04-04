import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.PrintStream;
import java.util.Random;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;
import javax.swing.text.BadLocationException;

public class GUI extends JFrame {
	private static final long serialVersionUID = 1L;
	TokenRing tokenRing = new TokenRing();
	private JTextArea textArea;

	private JButton buttonStart = new JButton("Start");
	private JButton buttonClear = new JButton("Clear");
	private JButton buttonExit = new JButton("Exit");

	private PrintStream standardOut;

	public GUI() {
		super("3D3 Networks Project 2 - Token Ring Simulation");

		textArea = new JTextArea(50, 10);
		textArea.setEditable(false);
		PrintStream printStream = new PrintStream(new CustomOutputStream(textArea));

		// keeps reference of standard output stream
		standardOut = System.out;

		// re-assigns standard output stream and error output stream
		System.setOut(printStream);
		System.setErr(printStream);

		// creates the GUI
		setLayout(new GridBagLayout());
		GridBagConstraints constraints = new GridBagConstraints();
		constraints.gridx = 0;
		constraints.gridy = 0;
		constraints.insets = new Insets(10, 10, 10, 10);
		constraints.anchor = GridBagConstraints.WEST;

		add(buttonStart, constraints);

		constraints.gridx = 1;
		add(buttonClear, constraints);
		
		constraints.gridx = 2;
		add(buttonExit, constraints);

		constraints.gridx = 0;
		constraints.gridy = 1;
		constraints.gridwidth = 2;
		constraints.fill = GridBagConstraints.BOTH;
		constraints.weightx = 1.0;
		constraints.weighty = 1.0;

		add(new JScrollPane(textArea), constraints);

		// adds event handler for button Start
		buttonStart.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent evt) {
				try {
					Random random = new Random();
					GlobalDataStore.netport_base = random.nextInt(10000)+1;
					tokenRingThread();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});

		// adds event handler for button Clear
		buttonClear.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent evt) {
				// clears the text area
				try {
					textArea.getDocument().remove(0,
							textArea.getDocument().getLength());
					standardOut.println("Text area cleared");
				} catch (BadLocationException ex) {
					ex.printStackTrace();
				}
			}
		});
		
		buttonExit.addActionListener(new ActionListener(){
			@Override
			public void actionPerformed(ActionEvent evt){
				System.exit(0);
			}
		});

		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setSize(480, 320);
		setLocationRelativeTo(null);	// centers on screen
	}

	//printing to GUI via thread concurrency
	private void tokenRingThread() throws Exception {
		Thread thread = new Thread(new Runnable() {
			@Override
			public void run() {
				tokenRing.init();
			}
		});
		thread.start();
	}
	
	//main
	public static void main(String[] args) {
		SwingUtilities.invokeLater(new Runnable() {
			@Override
			public void run() {
				new GUI().setVisible(true);
			}
		});
	}
}