package UserPackage;

import UserPackage.UserModel;

public class ProductManagerModel extends UserModel {
    public ProductManagerModel(int id, String name, String gmail, String password, String phone) {
        super(id, name, gmail, password, phone, "productmanager");
    }
    
    // ProductManager-specific methods
    public void approveProduct() {
        System.out.println("Product Manager approving product");
    }
    
    //implementation of abstract method/ polymorphic too
    @Override
    public String determineRedirectPage() {
        return "ProductManagerProfile.jsp";
    }
}