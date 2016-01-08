import java.util.Random;


public class GlobalDataStore
{
	//random port
	static Random random = new Random();
	public static int netport_base = random.nextInt(10000)+1;
	//public static int netport_base = 5485;
	
	//input file name
	public static String infile_name = new String("input-file-");
	
	//output file name
	public static String outfile_name = new String("output-file-");
	
	//THT limit
	public static Integer tht_byte_count = new Integer(400);
	//byte limit
	public static Integer byte_limit = 8;
}

