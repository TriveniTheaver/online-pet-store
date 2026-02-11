package EstorePackage;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class DashboardDBUtil {
	

     public static int getUserCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM user WHERE role='customer'";
        return getCount(query);
    }

    public static int getEmployeeCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM user WHERE role != 'customer'";
        return getCount(query);
    }

   

       public static int getPendingOrdersCount() throws SQLException {
        String query = "SELECT COUNT(order_id) FROM orders WHERE status = 'Pending'";
        return getCount(query);
    }
    
    public static int getOpenQueriesCount() throws SQLException {
        String query = "SELECT COUNT(id) FROM inquiries WHERE status = 'Open'";
        return getCount(query);
    }
    
      public static double getTodaysTotalSales() throws SQLException {
        String query = "SELECT SUM(total_price) FROM orders WHERE DATE(created_at) = CURRENT_DATE()";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            return rs.next() ? rs.getDouble(1) : 0.0;
        }
    }

    public static double getMonthlySalesTotal() throws SQLException {
        String query = "SELECT SUM(total_price) FROM orders WHERE MONTH(created_at) = MONTH(CURRENT_DATE())";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            return rs.next() ? rs.getDouble(1) : 0.0;
        }
    }
    
    private static int getCount(String query) throws SQLException {
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}
