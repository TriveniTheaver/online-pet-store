package UserPackage;

public class DefaultUserModel extends UserModel {
    public DefaultUserModel(int id, String name, String gmail, String password, String phone, String role) {
        super(id, name, gmail, password, phone, role);
    }
    
    @Override
    public String determineRedirectPage() {
        return "Home.jsp"; // Default page for unknown/guest roles
    }
}