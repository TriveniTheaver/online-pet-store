package EstorePackage;

public class User {
    private int id;
    private String name;
    private String gmail;
    private String password;
    private String phone;
    private String role;

    public User(int id, String name, String gmail, String password, String phone, String role) {
        this.id = id;
        this.name = name;
        this.gmail = gmail;
        this.password = password;
        this.phone = phone;
        this.role = role;
    }

    public User(String name, String gmail, String password, String phone, String role) {
		super();
		this.name = name;
		this.gmail = gmail;
		this.password = password;
		this.phone = phone;
		this.role = role;
	}

	// Getters and Setters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getGmail() { return gmail; }
    public String getPassword() { return password; }
    public String getPhone() { return phone; }
    public String getRole() { return role; }

    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setGmail(String gmail) { this.gmail = gmail; }
    public void setPassword(String password) { this.password = password; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setRole(String role) { this.role = role; }
}
