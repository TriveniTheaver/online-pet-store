package UserPackage;

import UserPackage.UserModel;

public class AdminModel extends UserModel {
    public AdminModel(int id, String name, String gmail, String password, String phone) {
        super(id, name, gmail, password, phone, "admin");
    }
    
    // Admin-specific methods
    public void manageSystemSettings() {
        System.out.println("Admin managing system settings");
    }
    
    @Override
    public String determineRedirectPage() {
        return "DashboardServlet";
    }
}