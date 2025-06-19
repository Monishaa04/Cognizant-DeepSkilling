//Eager initialization method
public class Logger {
	//creating instance for itself
	private static Logger instance = new Logger();
	
	//creating private constructor
	private Logger() {
		System.out.println("Instance created.");
	}
	
	//method to get the instance of the class
	public static Logger getInstance() {
		return instance;
	}
	
}
