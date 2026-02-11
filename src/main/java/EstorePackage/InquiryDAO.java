package EstorePackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;
import UserPackage.DBconnection;

public class InquiryDAO {
    
    // Create new inquiry
	public static boolean createInquiry(int customerId, String subject, String message) {
	    System.out.println("DEBUG: Starting inquiry creation for customer: " + customerId);
	    
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    boolean isSuccess = false;
	    
	    try {
	        con = DBconnection.getConnection();
	        if (con == null) {
	            System.out.println("DEBUG: Database connection failed");
	            return false;
	        }
	        
	        System.out.println("DEBUG: Connection established");
	        
	        String sql = "INSERT INTO inquiries (customer_id, subject, message, status, created_at) " +
	                     "VALUES (?, ?, ?, 'Open', NOW())";
	        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, customerId);
	        pstmt.setString(2, subject);
	        pstmt.setString(3, message);
	        
	        System.out.println("DEBUG: Executing SQL: " + pstmt.toString());
	        
	        int rowsAffected = pstmt.executeUpdate();
	        isSuccess = rowsAffected > 0;
	        
	        System.out.println("DEBUG: Rows affected: " + rowsAffected);
	        
	    } catch (Exception e) {
	        System.out.println("DEBUG: Exception in createInquiry:");
	        e.printStackTrace();
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	            System.out.println("DEBUG: Resources closed");
	        } catch (Exception e) {
	            System.out.println("DEBUG: Error closing resources:");
	            e.printStackTrace();
	        }
	    }
	    return isSuccess;
	}

	public static Integer getCustomerIdByEmail(String email) {
	    System.out.println("DEBUG: Getting customerId for email: " + email);
	    
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DBconnection.getConnection();
	        String sql = "SELECT id FROM users WHERE email = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, email);
	        
	        System.out.println("DEBUG: Executing SQL: " + pstmt.toString());
	        
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            int id = rs.getInt("id");
	            System.out.println("DEBUG: Found customerId: " + id);
	            return id;
	        }
	    } catch (Exception e) {
	        System.out.println("DEBUG: Exception in getCustomerIdByEmail:");
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    System.out.println("DEBUG: No customer found with email: " + email);
	    return null;
	}
    // Get all inquiries (for customer support)
    public static List<InquiryModel> getAllInquiries() {
        List<InquiryModel> inquiries = new ArrayList<>();
        try (Connection con = DBconnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(
                 "SELECT * FROM inquiries ORDER BY status, created_at DESC")) {
            
            while (rs.next()) {
                inquiries.add(mapInquiryFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiries;
    }
    
    // Get inquiries by customer ID (for customers)
    public static List<InquiryModel> getInquiriesByCustomerId(int customerId) {
        List<InquiryModel> inquiries = new ArrayList<>();
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "SELECT * FROM inquiries WHERE customer_id = ? ORDER BY created_at DESC")) {
            
            pstmt.setInt(1, customerId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    inquiries.add(mapInquiryFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiries;
    }
    
    // Get inquiries by customer email
    public static List<InquiryModel> getInquiriesByCustomerEmail(String email) {
        List<InquiryModel> inquiries = new ArrayList<>();
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "SELECT i.* FROM inquiries i JOIN users u ON i.customer_id = u.id WHERE u.email = ?")) {
            
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    inquiries.add(mapInquiryFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiries;
    }
    
    // Get single inquiry by ID
    public static InquiryModel getInquiryById(int id) {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "SELECT * FROM inquiries WHERE id = ?")) {
            
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapInquiryFromResultSet(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Update inquiry status (customer support)
    public static boolean updateInquiryStatus(int id, String status) {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "UPDATE inquiries SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?")) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, id);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Add response to inquiry (customer support)
    public static boolean addResponse(int id, String response) {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "UPDATE inquiries SET response = ?, response_date = CURRENT_TIMESTAMP, " +
                 "status = 'Resolved', updated_at = CURRENT_TIMESTAMP WHERE id = ?")) {
            
            pstmt.setString(1, response);
            pstmt.setInt(2, id);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Delete inquiry (customer)
    public static boolean deleteInquiry(int id, int customerId) {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "DELETE FROM inquiries WHERE id = ? AND customer_id = ?")) {
            
            pstmt.setInt(1, id);
            pstmt.setInt(2, customerId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
 // Update inquiry (customer version - doesn't allow status change)
    public static boolean updateInquiry(int id, int customerId, String subject, String message) {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "UPDATE inquiries SET subject = ?, message = ?, updated_at = CURRENT_TIMESTAMP " +
                 "WHERE id = ? AND customer_id = ?")) {
            
            pstmt.setString(1, subject);
            pstmt.setString(2, message);
            pstmt.setInt(3, id);
            pstmt.setInt(4, customerId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Delete inquiry (admin/support)
    public static boolean deleteInquiry(int id) {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "DELETE FROM inquiries WHERE id = ?")) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Helper method to map ResultSet to InquiryModel
    private static InquiryModel mapInquiryFromResultSet(ResultSet rs) throws Exception {
        return new InquiryModel(
            rs.getInt("id"),
            rs.getInt("customer_id"),
            rs.getString("subject"),
            rs.getString("message"),
            rs.getString("status"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at"),
            rs.getString("response"),
            rs.getTimestamp("response_date")
        );
    }
    //update for customer supporter
    public static boolean updateInquiry(int id, String subject, String message, String status) {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "UPDATE inquiries SET subject = ?, message = ?, status = ?, updated_at = CURRENT_TIMESTAMP " +
                 "WHERE id = ?")) {
            
            pstmt.setString(1, subject);
            pstmt.setString(2, message);
            pstmt.setString(3, status);
            pstmt.setInt(4, id);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public static boolean updateInquiry(InquiryModel model) {
        boolean success = false;
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = DBconnection.getConnection(); 

            String sql = "UPDATE inquiries SET subject = ?, message = ?, status = ? WHERE id = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, model.getSubject());
            stmt.setString(2, model.getMessage());
            stmt.setString(3, model.getStatus());
            stmt.setInt(4, model.getId());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                success = true;
            }

            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    
 // InquiryController.java 
    public static int getTotalInquiriesCount() {
        try (Connection con = DBconnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM inquiries")) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int getSolvedInquiriesCount() {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "SELECT COUNT(*) FROM inquiries WHERE status IN ('Resolved', 'Closed')")) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static int getOpenInquiriesCount() {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "SELECT COUNT(*) FROM inquiries WHERE status IN ('Open', 'In Progress')")) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

   

   

    public static List<InquiryModel> getSolvedInquiries() {
        List<InquiryModel> inquiries = new ArrayList<>();
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "SELECT * FROM inquiries WHERE status IN ('Resolved', 'Closed') ORDER BY response_date DESC")) {
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    inquiries.add(mapInquiryFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiries;
    }

    public static List<InquiryModel> getOpenInquiries() {
        List<InquiryModel> inquiries = new ArrayList<>();
        try (Connection con = DBconnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(
                 "SELECT * FROM inquiries WHERE status IN ('Open', 'In Progress') ORDER BY created_at DESC")) {
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    inquiries.add(mapInquiryFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiries;
    }
   

   

}