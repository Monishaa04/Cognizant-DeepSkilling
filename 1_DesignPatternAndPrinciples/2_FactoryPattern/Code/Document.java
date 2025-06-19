abstract class DocumentType{
	abstract void open();
}

class WordDocument extends DocumentType{
	 public void open() {
		 System.out.println("It is word document");
	 }
}

class PdfDocument extends DocumentType{
	 public void open() {
		 System.out.println("It is pdf document");
	 }
}

class ExcelDocument extends DocumentType{
	 public void open() {
		 System.out.println("It is excel document");
	 }
}

abstract class DocumentFactory{
	abstract DocumentType createDocument();
}

class WordFactory extends DocumentFactory{
	public DocumentType createDocument() {
		return new WordDocument();
	}
}

class PdfFactory extends DocumentFactory{
	public DocumentType createDocument() {
		return new PdfDocument();
	}
}

class ExcelFactory extends DocumentFactory{
	public DocumentType createDocument() {
		return new ExcelDocument();
	}
}

public class Document {
	public static void main(String[] args) {
		DocumentFactory factory=new WordFactory();
		DocumentType wordtype=factory.createDocument();
		wordtype.open();
		
		factory=new PdfFactory();
		DocumentType pdftype=factory.createDocument();
		pdftype.open();
		
		factory=new ExcelFactory();
		DocumentType exceltype=factory.createDocument();
		exceltype.open();
	}
}
