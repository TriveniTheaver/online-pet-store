package UserPackage;

import UserPackage.UserModel;

public class CustomerModel extends UserModel {
    public CustomerModel(int id, String name, String gmail, String password, String phone) {
        super(id, name, gmail, password, phone, "customer");
    }
    
    // Customer-specific methods
    public void placeOrder() {
        System.out.println("Customer placing order");
    }
    
    
    @Override
    public String determineRedirectPage() {
        return "CustomerProfile.jsp";
    }
}