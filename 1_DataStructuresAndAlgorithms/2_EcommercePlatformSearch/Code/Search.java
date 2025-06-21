
//Big O notation:
//	Big O notation is used to describes the performance of an algorithm for 
//	the given input size n with respect to the time and space complexity.

//Search operations:
//	Linear search:
//		Best case:O(1)
//		Average/Worst case: O(n)

//	Binary search: (requires the sorted array)
//		Best case:O(1)
//		Average/Worst case: O(log n)

//Analysis:
//	Binary search is more suitable as it has time complexity of O(log n)
//	Linear search is used for small array and it's not necessary to have sorted array.
//	Binary search is used for large array and it should be sorted.



import java.util.*;

class Product {
	public int productId;
	public String productName;
	public String category;
	
	public Product(int id,String name,String category) {
		this.productId=id;
		this.productName=name;
		this.category=category;
	}
	
	public void display() {
		System.out.println("ID: "+productId+" Name: "+productName+" Category: "+category);
	}
}

public class Search{
	
	public static Product linearSearch(Product[] products,String searchName) {
		for(Product p:products) {
			if(p.productName.equalsIgnoreCase(searchName)) return p;
		}
		return null;
	}
	
	public static Product binarySearch(Product[] products,String searchName) {
		int left=0;
		int right=products.length-1;
		
		while(left<=right) {
			int mid=(left+right)/2;
			int comparison=searchName.compareToIgnoreCase(products[mid].productName);
			
			if(comparison==0) return products[mid];
			else if(comparison<0) right=mid-1;
			else left=mid+1;
		}
		return null;
	}
	
	public static void sortByName(Product[] products) {
		Arrays.sort(products,Comparator.comparing(p->p.productName.toLowerCase()));
	}
	public static void main(String[] args) {
		Product[] products= {new Product(1, "Laptop", "Electronics"),
	            new Product(2, "Mobile", "Electronics"),
	            new Product(3, "Shoes", "Fashion"),
	            new Product(4, "Book", "Education")
		};
		
		Scanner sc=new Scanner(System.in);
		System.out.println("Enter the product name to search: ");
		String searchName=sc.next();
		
		System.out.println("Linear Search:");
		Product linearRes=linearSearch(products,searchName);
		if(linearRes != null) {
			linearRes.display();
		}else {
			System.out.println("Product is not found");
		}
		
		System.out.println("Binary Search:");
		sortByName(products);
		Product binaryRes=binarySearch(products,searchName);
		if(binaryRes != null) {
			binaryRes.display();
		}else {
			System.out.println("Product is not found");
		}
		sc.close();	
	}
}

