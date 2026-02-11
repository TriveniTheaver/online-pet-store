package UserPackage;

//simple factory pattern
//The factory encapsulates the object creation logic


public class UserFactory {
    public static UserModel createUser(int id, String name, String email, 
                                     String password, String phone, String role) {
        switch(role.toLowerCase()) {
            case "admin":
                return new AdminModel(id, name, email, password, phone);
            case "productmanager":
                return new ProductManagerModel(id, name, email, password, phone);
            case "customer":
                return new CustomerModel(id, name, email, password, phone);
            case "customersupport":
                return new CustomerSupportModel(id, name, email, password, phone);
            default:
                throw new IllegalArgumentException("Unknown user role: " + role);
        }
    }
}
