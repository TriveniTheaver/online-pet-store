package UserPackage;

import UserPackage.UserModel;

public class CustomerSupportModel extends UserModel {
    public CustomerSupportModel(int id, String name, String gmail, String password, String phone) {
        super(id, name, gmail, password, phone, "customersupport");
    }
    
    // Support-specific methods
    public void resolveInquiry() {
        System.out.println("Customer Supporter resolving inquiry");
    }
    
    @Override
    public String determineRedirectPage() {
        return "CustomerSupportProfile.jsp";
    }
}