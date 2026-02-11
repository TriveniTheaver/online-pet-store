<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
HttpSession sessionUser = request.getSession(false);
if (sessionUser == null || sessionUser.getAttribute("userId") == null) {
    response.sendRedirect("Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Details</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .order-details-container {
            background: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 10px;
            max-width: 1000px;
            margin: 30px auto;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .order-info {
            margin-bottom: 30px;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 5px;
        }
        .order-info p {
            margin: 10px 0;
            font-size: 16px;
        }
        .order-items-table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
        }
        .order-items-table th {
            background-color: #b08a6c;
            color: white;
            padding: 15px;
            text-align: left;
        }
        .order-items-table td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            vertical-align: middle;
        }
        .item-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .product-cell {
            display: flex;
            align-items: center;
        }
        .product-info {
            display: flex;
            flex-direction: column;
        }
        .product-name {
            font-weight: 600;
            margin-bottom: 5px;
        }
        .product-id {
            color: #666;
            font-size: 14px;
        }
        .total-row {
            font-weight: bold;
            background-color: #f5f5f5;
        }
        .back-btn {
            margin-top: 25px;
            display: inline-block;
            padding: 12px 25px;
            background-color: #b08a6c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .back-btn:hover {
            background-color: #9a7a60;
        }
        .status-pending {
            color: #e67e22;
            font-weight: bold;
        }
        .status-completed {
            color: #2ecc71;
            font-weight: bold;
        }
        .status-cancelled {
            color: #e74c3c;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="CustomerProfile.jsp">Dashboard</a></li>
            <li><a href="CustomerInquiryServlet">My Inquiries</a></li>
            <li><a href="OrderHistoryServlet">Order History</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </nav>

    <div class="order-details-container">
        <h2>Order Details #${order.orderId}</h2>
        
        <div class="order-info">
            <p><strong>Status:</strong> 
                <span class="status-${order.status.toLowerCase()}">${order.status}</span>
            </p>
            <p><strong>Order Date:</strong> 
                <fmt:formatDate value="${order.createdAt}" pattern="MMMM dd, yyyy 'at' hh:mm a" />
            </p>
            <br><br>
            <br>
        </div>
        
        
        <table class="order-items-table">
            
            <tbody>
                <c:forEach var="item" items="${order.items}">
                    <tr>
                        <td>
                            <div class="product-cell">
                                <img src="${item.imageUrl}" alt="${item.name}" class="item-image">
                                <div class="product-info">
                                    <span class="product-name">${item.name}</span>
                                    <span class="product-id">Product ID: ${item.productId}</span>
                                </div>
                            </div>
                        </td>
                        <td>$<fmt:formatNumber value="${item.price}" minFractionDigits="2" /></td>
                        <td>${item.quantity}</td>
                        <td>$<fmt:formatNumber value="${item.price * item.quantity}" minFractionDigits="2" /></td>
                    </tr>
                </c:forEach>
                <tr class="total-row">
                    <td colspan="3" style="text-align: right;"><strong>Order Total:</strong></td>
                    <td><strong>$<fmt:formatNumber value="${order.totalPrice}" minFractionDigits="2" /></strong></td>
                </tr>
            </tbody>
        </table>
        
        <a href="OrderHistoryServlet" class="back-btn">Back to Order History</a>
    </div>

    <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p>
        </div>
    </footer>
</body>
</html>