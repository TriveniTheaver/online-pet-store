<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="UserPackage.SessionUtil" %>

<%
    // Security check - validate customer role and active session
    if (!SessionUtil.validateRole(request, response, "customer")) {
        return;
    }

    // Verify order confirmation data exists
    if (session.getAttribute("orderSuccess") == null || 
        session.getAttribute("orderItems") == null || 
        session.getAttribute("orderAmount") == null) {
        
        // Clear any partial order data
        session.removeAttribute("orderSuccess");
        session.removeAttribute("orderItems");
        session.removeAttribute("orderAmount");
        
        response.sendRedirect("Cart.jsp?error=No order confirmation data found");
        return;
    }

    // Generate timestamp for order confirmation
    String orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    
    // Generate a unique order ID (you might want to use a real order ID from database)
    String orderId = "ORD-" + System.currentTimeMillis();
    session.setAttribute("orderId", orderId);
    
    // Set cache control headers
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation | MyPetStore</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .confirmation-container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .confirmation-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #b08a6c;
        }
        
        .confirmation-icon {
            font-size: 4rem;
            color: #4CAF50;
            margin-bottom: 1rem;
        }
        
        .order-details {
            margin: 2rem 0;
            padding: 1.5rem;
            background: #f9f9f9;
            border-radius: 8px;
        }
        
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
        }
        
        .order-table th, .order-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .order-table th {
            background-color: #f2f2f2;
            font-weight: 600;
        }
        
        .order-table tfoot td {
            font-weight: bold;
            background-color: #f2f2f2;
        }
        
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn {
            padding: 12px 24px;
            border-radius: 5px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background-color: #b08a6c;
            color: white;
            border: 2px solid #b08a6c;
        }
        
        .btn-primary:hover {
            background-color: #9a755a;
            border-color: #9a755a;
        }
        
        .btn-secondary {
            background-color: white;
            color: #b08a6c;
            border: 2px solid #b08a6c;
        }
        
        .btn-secondary:hover {
            background-color: #f5f5f5;
        }
        
        @media (max-width: 768px) {
            .confirmation-container {
                padding: 1rem;
                margin: 1rem;
            }
            
            .order-table {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="CustomerProfile.jsp">Dashboard</a></li>
            <li><a href="Shop.jsp">Shop</a></li>
            <li><a href="#">Adopt</a></li>
            <li><a href="#">Blog</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </nav>

    <div class="confirmation-container">
        <div class="confirmation-header">
            <div class="confirmation-icon">✓</div>
            <h1>Order Confirmed!</h1>
            <p class="lead">Thank you for your purchase, ${userName}!</p>
            <p>A confirmation email has been sent to ${userEmail}</p>
        </div>
        
        <div class="order-details">
            <h2>Order Summary</h2>
            <p><strong>Order Number:</strong> ${orderId}</p>
            <p><strong>Date:</strong> <%= orderDate %></p>
            <p><strong>Status:</strong> Processing</p>
            
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${orderItems}">
                        <tr>
                            <td>${item.name}</td>
                            <td>$${item.price}</td>
                            <td>${item.quantity}</td>
                            <td>$${item.quantity * Double.parseDouble(item.price)}</td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3" style="text-align: right;">Subtotal</td>
                        <td>$${orderAmount}</td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: right;">Shipping</td>
                        <td>$0.00</td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: right;"><strong>Total</strong></td>
                        <td><strong>$${orderAmount}</strong></td>
                    </tr>
                </tfoot>
            </table>
        </div>
        
        <div class="action-buttons">
            <a href="CustomerProfile.jsp" class="btn btn-primary">View Dashboard</a>
            <a href="Shop.jsp" class="btn btn-secondary">Continue Shopping</a>
        </div>
    </div>

    <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p>
            <p>Need help? Contact our <a href="CustomerSupport.jsp">customer support</a></p>
        </div>
    </footer>
</body>
</html>