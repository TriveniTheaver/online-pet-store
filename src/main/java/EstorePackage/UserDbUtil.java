package EstorePackage;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import UserPackage.DBconnection;
import EstorePackage.User;

public class UserDbUtil {
    private static boolean isSuccess;
    private static Connection con = null;
    private static PreparedStatement stmt = null;
    private static ResultSet rs = null;

    // Retrieve all users
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            con = DBconnection.getConnection();
            String sql = "SELECT * FROM user where role='customer';";
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
     
                    int id=rs.getInt("id");
                    String name=rs.getString("name");
                    String gmail=rs.getString("gmail");
                    String pw=rs.getString("password");
                    String phone=rs.getString("phone");
                    String role=rs.getString("role");
       
                    users.add(new User(id,name,gmail,pw,phone,role));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
    
    
    //get all EMPLOYEES
    // Retrieve all employees
    public static List<User> getAllEmployees() {
        List<User> emp = new ArrayList<>();
        try {
            con = DBconnection.getConnection();
            String sql = "SELECT * FROM user WHERE role IN ('admin', 'productmanager', 'customersupport');";
            stmt = con.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
     
                    int id=rs.getInt("id");
                    String name=rs.getString("name");
                    String gmail=rs.getString("gmail");
                    String pw=rs.getString("password");
                    String phone=rs.getString("phone");
                    String role=rs.getString("role");
       
                    emp.add(new User(id,name,gmail,pw,phone,role));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emp;
    }


    //Adding new User
    public static boolean addNew(User user) {
        try {
            // Check connection
            con = DBconnection.getConnection();
            if (con == null) {
                System.out.println("Database connection failed.");
                return false;
            }

            // Debug logs for input parameters
            System.out.println("Name: " + user.getName());
            System.out.println("Email: " + user.getGmail());
            System.out.println("Password: " + user.getPassword());
            System.out.println("Phone: " + user.getPhone());
            System.out.println("Role: " + user.getRole());

            // SQL query
            String sql = "insert into user (name, gmail, password, phone, role) values (?, ?, ?, ?, ?)";
            stmt = con.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getGmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getRole());

            // Execute query
            int rs = stmt.executeUpdate();

            // Check if insertion was successful
            if (rs > 0) {
                isSuccess = true;
                System.out.println("User added successfully!");
            } else {
                isSuccess = false;
                System.out.println("Failed to add user!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            isSuccess = false;
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return isSuccess;
    }
    
    
    
    
    
    //Update user
	public static boolean updateuser(String id,String name,String gmail,String pwd,String phone,String role) {
		
		try {
			int Iid=Integer.parseInt(id);
			con=DBconnection.getConnection();
			
			 String sql = "update user set name=?, gmail=?, password=?, phone=?, role=? where id=?";
		        stmt = con.prepareStatement(sql);
		        stmt.setString(1, name);
		        stmt.setString(2, gmail);
		        stmt.setString(3, pwd);
		        stmt.setString(4, phone);
		        stmt.setString(5, role);
		        stmt.setInt(6, Iid);
		        	
		        //debugging
		        System.out.println("Executing SQL: " + sql);
			
			int rs = stmt.executeUpdate();
			
		
			if(rs>0) {
				isSuccess=true;
			}else {
				isSuccess=false;
			}
		}catch(Exception e){
			 e.printStackTrace();
		     isSuccess = false;
		}
		
		return isSuccess;
	}
	
	
	
	
    
    // Delete a user
    public static boolean deleteUser(int userId) {
        try {
        	con = DBconnection.getConnection();
        	String sql = "DELETE FROM user WHERE id = " + userId;
        	stmt = con.prepareStatement(sql);
        	int r=stmt.executeUpdate();

            isSuccess = (r > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    
    
    //----------------------------------------------------------
	public static List<User> getUser(String id) {
			int convertedID=Integer.parseInt(id);
			ArrayList<User> user=new ArrayList<>();
			
				try {
					con=DBconnection.getConnection();
					stmt=con.prepareStatement(id);
					
					
					String sql="select* from user where id='"+convertedID+"';";
					rs=stmt.executeQuery(sql);
					
					
					
					//next is a boolean method which will return true if query executed successfully
					while(rs.next()) {
						//use getInt/getString method to retrieve data from DB with the column index
						int uid=rs.getInt(1);
						String name=rs.getString(2);
						String gmail=rs.getString(3);
						String pw=rs.getString(4);
						String phone=rs.getString(5);
						String role=rs.getString(6);
						
						//creating object from User model class 
						User u=new User(uid,name,gmail,pw,phone,role);
						user.add(u);
					}
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				
			return user;
		
	
	}


}
