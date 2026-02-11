package EstorePackage;

//represents the structure of a product
public class ProductModel {
	private int id;
	private String name;
	private String price;
	private String category;
	private int quantity;
	private String description;
	private String imageUrl; 
	
	
	public ProductModel(int id, String name, String price, String category, int quantity, String description,String imageUrl) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.category = category;
		this.quantity = quantity;
		this.description = description;
		this.imageUrl= imageUrl;
		
	}


	public String getImageUrl() {
		return imageUrl;
	}


	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPrice() {
		return price;
	}


	public void setPrice(String price) {
		this.price = price;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}
	
	// validation method for insert
    public static boolean isValidProduct(String name, String price, int quantity) {
        return name != null && !name.trim().isEmpty() &&
               price != null && price.matches("^\\d+(\\.\\d{1,2})?$") &&
               quantity >= 0;
    }
    
    
    // validation method for update
    public static boolean isValidUpdate(int id, String name, String price, int quantity) {
        return id > 0 && 
               isValidProduct(name, price, quantity); // Reuses existing validation
    }
    
    
    //validation for deletion
    public static boolean isValidDelete(int id) {
        return id > 0; // Simple check for valid ID
    }
    
    
	
	 
}
