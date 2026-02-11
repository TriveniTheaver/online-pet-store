<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="UserPackage.SessionUtil" %>
<% 
if (!SessionUtil.validateRole(request, response, "customer")) {
    return;
}
%>
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
    <title>Order History</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .order-container {
            background: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 10px;
            max-width: 1000px;
            margin: 30px auto;
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .order-table th, .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .order-table th {
            background-color: #b08a6c;
            color: white;
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
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-view {
            background-color: #3498db;
            color: white;
        }
        .btn-cancel {
            background-color: #e74c3c;
            color: white;
        }
        .btn-delete {
            background-color: #e74c3c;
            color: white;
            margin-left: 5px;
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

    <div class="order-container">
        <h2>Your Order History</h2>
        
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">
                <c:choose>
                    <c:when test="${param.success eq 'cancel'}">Order cancelled successfully!</c:when>
                    <c:when test="${param.success eq 'delete'}">Order deleted successfully!</c:when>
                </c:choose>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-error">
                <c:choose>
                    <c:when test="${param.error eq 'unauthorized'}">You are not authorized to perform this action.</c:when>
                    <c:when test="${param.error eq 'cannot_cancel'}">Only pending orders can be cancelled.</c:when>
                    <c:otherwise>Error processing your request. Please try again.</c:otherwise>
                </c:choose>
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty orders}">
                <p>You haven't placed any orders yet.</p>
            </c:when>
            <c:otherwise>
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.orderId}</td>
                                <td><!-- Add date display when available --></td>
                                <td>$${order.totalPrice}</td>
                                <td class="status-${order.status.toLowerCase()}">${order.status}</td>
                                <td>
                                    <a href="OrderDetailsServlet?orderId=${order.orderId}" class="btn btn-view">View</a>
                                    <c:if test="${order.status eq 'Pending'}">
                                        <form action="CancelOrderServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <button type="submit" class="btn btn-cancel">Cancel</button>
                                        </form>
                                    </c:if>
                                    <form action="DeleteOrderServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <button type="submit" class="btn btn-delete">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p>
        </div>
    </footer>
</body>
</html>