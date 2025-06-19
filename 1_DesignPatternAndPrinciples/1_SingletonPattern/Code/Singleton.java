//implementing the singleton pattern for class "Logger"
public class Singleton {

	public static void main(String[] args) {
		
		Logger obj = Logger.getInstance();
		Logger obj1 = Logger.getInstance();
		
		//verify that only one object is created
		if(obj==obj1) {
			System.out.println("Singleton pattern is followed.");
		}
		else {
			System.out.println("Singleton pattern is not followed.");
		}
	}

}
