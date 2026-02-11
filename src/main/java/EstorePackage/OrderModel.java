package EstorePackage;

import java.sql.Timestamp;
import java.util.List;

public class OrderModel {
    private int orderId;
    private int customerId;
    private List<CartModel> items; // List of items in the order
    private double totalPrice;
    private String status; // e.g., "Pending", "Confirmed", "Shipped"
    private Timestamp createdAt;
    
    // Constructor
    public OrderModel(int orderId, int customerId, List<CartModel> items, double totalPrice, String status) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.items = items;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public List<CartModel> getItems() {
        return items;
    }

    public void setItems(List<CartModel> items) {
        this.items = items;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}