import java.net.*;

public class TokenRing
{		
	
	public ServerSocket s1;
	public ServerSocket s2;
	public ServerSocket s3;
	public ServerSocket s4;
	public ServerSocket s5;
	public ClientNode node1;
	public ClientNode node2;
	public ClientNode node3;
	public ClientNode node4;
	public ClientNode node5;
	
	public void init(){
		
		try{
			//create server sockets for each node 
			s1 = new ServerSocket(GlobalDataStore.netport_base+1);
			s2 = new ServerSocket(GlobalDataStore.netport_base+2);
			s3 = new ServerSocket(GlobalDataStore.netport_base+3);
			s4 = new ServerSocket(GlobalDataStore.netport_base+4);
			s5 = new ServerSocket(GlobalDataStore.netport_base+5);
	
			//create client nodes for the token ring
			//these wont have the initial token for sending
			//s1 contains the initial token
			node2 = new ClientNode(s2, GlobalDataStore.netport_base+3, false);
			node3 = new ClientNode(s3, GlobalDataStore.netport_base+4, false);
			node4 = new ClientNode(s4, GlobalDataStore.netport_base+5, false);
			node5 = new ClientNode(s5, GlobalDataStore.netport_base+1, false);
			
			//client node will be the initial holder of the token 
			node1 = new ClientNode(s1, GlobalDataStore.netport_base+2, true);
	
			/*while(node1.isAlive()){
				
			}*/
			
			/*while(done()){
				
			}*/
			
			Thread.sleep(10);
			
			node1.exit();
			node2.exit();
			node3.exit();
			node4.exit();
			node5.exit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void restart(){
		System.out.println("Restarting ... generating another frame");
		
	}
}
	


