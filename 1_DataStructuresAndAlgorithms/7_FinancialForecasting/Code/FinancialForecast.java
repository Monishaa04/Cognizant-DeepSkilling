//Recursion:
//	Recursion is the technique which is used to make the problems in smaller way for solving
//	and it can be called itself.

//	Base case: A condition to stop the recursion.
//	Recursion case: The part where the function calls itself with the smaller parts.

//Time complexity: O(n) for the n years.

//Optimization: we can use normal iteration or memoization.


import java.util.*;

public class FinancialForecast {
	public static double predictionValue(double initialVal, double growthRate, int year) {
		if(year==0) return initialVal;
		return predictionValue(initialVal,growthRate,year-1)*(1+growthRate);
	}

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		
		System.out.println("Enter the current value:");
		double initialVal=sc.nextDouble();
		
		System.out.println("Enter the growth rate:");
		double growthRate=sc.nextDouble();
		
		System.out.println("Enter the year:");
		int year=sc.nextInt();
		
		double futureVal=predictionValue(initialVal,growthRate,year);
		System.out.println("Forecating values after "+year+" years: "+futureVal);
		
		sc.close();

	}

}
