package EstorePackage;

public class CartModel {
    private int id;          // Product ID
    private String name;     // Product name
    private String price;    // Product price
    private String imageUrl; // Product image URL
    private int quantity;    // Quantity of the product in the cart

    // Constructor
    public CartModel(int id, String name, String price, String imageUrl, int quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.quantity = quantity;
    }

    // Getters and Setters
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

	public int getProductId() {
		// TODO Auto-generated method stub
		return 0;
	}
}