package UserPackage;

//general blueprint for all user types
public abstract class UserModel {
	private int id;
	private String name;
	private String gmail;
	private String password;
	private String phone;
	private String role; 
	
	public UserModel(int id, String name, String gmail, String password, String phone,String role) {
		super();
		this.id = id;
		this.name = name;
		this.gmail = gmail;
		this.password = password;
		this.phone = phone;
		this.role = role;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public int getId() {
		return id;
	}
	public Integer getCustomerId() {
	    return this.id;
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

	public String getGmail() {
		return gmail;
	}

	public void setGmail(String gmail) {
		this.gmail = gmail;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	// Abstract method
	public abstract String determineRedirectPage();
    
    
	
}
