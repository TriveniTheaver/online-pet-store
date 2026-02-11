package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    // Connect DB
    private static boolean isSuccess;
    private static Connection con = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;
      
  //login validation
    public static List<UserModel> loginValidate(String gmail, String password) {
        ArrayList<UserModel> user = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try {
            conn = DBconnection.getConnection();
            String sql = "select * from user where gmail = ? and password = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, gmail);
            pst.setString(2, password);
            
            rs = pst.executeQuery();
            
            if (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                String email = rs.getString(3);
                String pass = rs.getString(4);
                String phone = rs.getString(5);
                String role = rs.getString(6).toLowerCase();
                
                
                 
             // Factory Pattern -> creates/instantiates appropriate UserModel using factory pattern(instead of manually creating the user object )
                
                UserModel u = UserFactory.createUser(id, name, email, pass, phone, role);
                
                user.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources...
        }
        return user;
    }
    
    
    
    
    
    
    // insert data function-register new user
    public static boolean insertdata(String name, String gmail, String password, String phone, String role) {
        boolean isSuccess = false;
        
        try {
            // DB connection call
            con = DBconnection.getConnection();
            stmt = con.createStatement();
            
            // sql query - using parameterized query
            String sql = "insert into user values(0,?,?,?,?,?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, gmail);
            pst.setString(3, password);
            pst.setString(4, phone);
            pst.setString(5, role);
            
            int result = pst.executeUpdate();
            if (result > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error inserting data: " + e.getMessage());
        } finally {
            // Close resources
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        return isSuccess;
    }
    
   
    
 
    
    
   
}

