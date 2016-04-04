import java.io.*;
import java.util.Random;

public class TokenFrame
{
	private String this_node_name; //name of node for logging 
	private Integer access_control; //AC: 0=token; 1=data 
	private Integer data_size; //data size in multiples of 50 
	private Integer dest; //destination node for frame 
	private Integer src; //source node of frame 
	private String data; //data string of frame 
	private Integer frame_status; //frame status

	//access methods
	public Integer access_control() {return this.access_control;}
	public Integer data_size(){return this.data_size;}
	public Integer dest(){return this.dest;}
	public Integer src(){return this.src;}
	public String data(){return this.data;}
	public Integer frame_status(){return this.frame_status;}

	//var access methods
	public void set_access_control(int ac) {this.access_control= new Integer(ac);}
	public void set_dest(int da){this.dest=new Integer(da);}
	public void set_src(int sa){this.src=new Integer(sa);}
	public void set_data(String input){this.data=input;}
	
	public void set_frame_status() {
		//set random frame status to drop packets
		//orphaned frame possibility
		Random rand = new Random();
		int ac = rand.nextInt(2);
		
		if (ac == 0){
			frame_status = 0;
		}
		else if (ac == 1){
			frame_status = 1;
		}
		
		//set frame status to fixed
		//frame_status = 0;
	}

	public void set_data_size()
	{
		if (this.data.length() != 0)
		{
				int ret = multiple_of_limit(this.data.length(), GlobalDataStore.byte_limit);
				this.data_size = new Integer(ret);
		}
	}
	private int multiple_of_limit(int num, int check)
	{
		if (num < check)
			return check;
		else if ((num%check) != 0)
			return multiple_of_limit(num, check+GlobalDataStore.byte_limit);
		else return 0;
	}

	// method for populating data from input string
	public void from_input(String input)
	{
		System.out.println(this.this_node_name+": Populating TokenFrame from input");
		System.out.println(this.this_node_name+": FRAME: "+input);
		log_frame(this.this_node_name, input);
		try {
			String[] list = input.split(",");
			this.access_control = new Integer(list[0]);
			this.data_size = new Integer(list[1]);
			this.dest = new Integer(list[2]);
			this.src = new Integer(list[3]);
			this.data = new String(list[4]);
			this.frame_status = new Integer(0);
		}
		catch (ArrayIndexOutOfBoundsException index)
		{
			System.err.println(this.this_node_name+": from input: Array Index Bound Exceeded");
			this.access_control = new Integer(1); 
		}
	}

	//method for populating data from a received frame 
	public void from_existing(String input)
	{
		System.out.println(this.this_node_name+": Populating token frame from incoming frame");
		System.out.println(this.this_node_name+": FRAME: "+input);
		log_frame(this.this_node_name, input);
		try {
			String[] list = input.split(",");
			this.access_control = new Integer(list[0]);
			this.data_size = new Integer(list[1]);
			this.dest = new Integer(list[2]);
			this.src = new Integer(list[3]);
			this.data = new String(list[4]);
			this.frame_status = new Integer(0);
		}
		catch (ArrayIndexOutOfBoundsException index)
		{
			System.err.println(this.this_node_name+": from input: Array Index Bound Exceeded");
			this.access_control = new Integer(1); 
		}
	}
	
	//frame logging for debugging
	void log_frame(String node_name, String frame)
	{
		try
		{
			PrintWriter log = new PrintWriter(new FileWriter("log-file-"+node_name, true));
			//log.println(this.this_node_name+": FRAME: "+input);
			log.println(frame);
			log.close();
		}
		catch (IOException io)
		{
			System.err.println("log frame: IO Error, Write");
		}
	}
	
	//method for creating a string from the object data
	public String print()
	{
		return this.access_control.toString()+","
			+this.data_size.toString()+","
			+this.dest.toString()+","
			+this.src.toString()+","
			+this.data;
	}

	//newline printing
	public String println()
	{
		return print()+"\n";
	}

	//object constructor for a token ring frame
	TokenFrame(String node_name)
	{
		this.this_node_name = node_name;
		this.access_control = new Integer(0);
		this.data_size = new Integer(0);
		this.dest = new Integer(0);
		this.src = new Integer(0);
		this.data = new String("");
		this.frame_status = new Integer(0);
	}
}

