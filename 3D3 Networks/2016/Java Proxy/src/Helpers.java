import java.util.regex.Pattern;

public class Helpers {
	public static final int PORT = 2016;
	public static final int NON_CONNECT_PORT = 80;
	public static final int CONNECT_PORT = 443;
	
	public static final String HOST = "localhost";
	public static final String USER_AGENT = "Mozilla/5.0";
	
    public static final Pattern GET_PATTERN = 
    		Pattern.compile("GET http://(.*)/ HTTP/(1\\.[01])",
            Pattern.CASE_INSENSITIVE);
	
	public static final Pattern CONNECT_PATTERN = 
			Pattern.compile("CONNECT (.+):(.+) HTTP/(1\\.[01])",
			Pattern.CASE_INSENSITIVE);
}
