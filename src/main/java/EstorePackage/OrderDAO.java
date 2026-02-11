package EstorePackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import UserPackage.DBconnection;

public class OrderDAO {

    // Create a new order
    public static boolean createOrder(int customerId, List<CartModel> items, double totalPrice) {
        boolean isSuccess = false;
        try {
            Connection con = DBconnection.getConnection();
            String sql = "INSERT INTO orders (customer_id, total_price, status) VALUES (?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, customerId);
            pstmt.setDouble(2, totalPrice);
            pstmt.setString(3, "Pending"); // Default status
            int rowsInserted = pstmt.executeUpdate();

            if (rowsInserted > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

 
  
 // Get all orders for a customer
    public static List<OrderModel> getOrdersByCustomerId(int customerId) {
        List<OrderModel> orders = new ArrayList<>();
        try {
            Connection con = DBconnection.getConnection();
            String sql = "SELECT * FROM orders WHERE customer_id = ? ORDER BY created_at DESC";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, customerId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                double totalPrice = rs.getDouble("total_price");
                String status = rs.getString("status");

                List<CartModel> items = getOrderItems(orderId);
                OrderModel order = new OrderModel(orderId, customerId, items, totalPrice, status);
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Get single order by ID
    public static OrderModel getOrderById(int orderId) {
        OrderModel order = null;
        try {
            Connection con = DBconnection.getConnection();
            String sql = "SELECT * FROM orders WHERE order_id = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int customerId = rs.getInt("customer_id");
                double totalPrice = rs.getDouble("total_price");
                String status = rs.getString("status");
                Timestamp createdAt = rs.getTimestamp("created_at");
                
                List<CartModel> items = getOrderItems(orderId);
                order = new OrderModel(orderId, customerId, items, totalPrice, status);
                order.setCreatedAt(createdAt); // Add this setter to your OrderModel
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    // Get items for a specific order
    public static List<CartModel> getOrderItems(int orderId) {
        List<CartModel> items = new ArrayList<>();
        try {
            Connection con = DBconnection.getConnection();
            String sql = "SELECT oi.*, p.image_url FROM order_items oi " +
                         "JOIN product p ON oi.product_id = p.id " +
                         "WHERE oi.order_id = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                String name = rs.getString("name");
                String price = rs.getString("price");
                String imageUrl = rs.getString("image_url");
                int quantity = rs.getInt("quantity");

                CartModel item = new CartModel(productId, name, price, imageUrl, quantity);
                items.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    // Update order status
    public static boolean updateOrderStatus(int orderId, String newStatus) {
        boolean success = false;
        try {
            Connection con = DBconnection.getConnection();
            String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, orderId);
            
            int rowsUpdated = pstmt.executeUpdate();
            success = rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // Delete an order
    public static boolean deleteOrder(int orderId) {
        boolean success = false;
        Connection con = null;
        try {
            con = DBconnection.getConnection();
            con.setAutoCommit(false); // Start transaction
            
           
            
            // Then delete the order
            String deleteOrderSql = "DELETE FROM orders WHERE order_id = ?";
            PreparedStatement deleteOrderStmt = con.prepareStatement(deleteOrderSql);
            deleteOrderStmt.setInt(1, orderId);
            int rowsDeleted = deleteOrderStmt.executeUpdate();
            
            con.commit(); // Commit transaction
            success = rowsDeleted > 0;
        } catch (Exception e) {
            try {
                if (con != null) con.rollback(); // Rollback on error
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (con != null) con.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return success;
    }
    
       
    }
