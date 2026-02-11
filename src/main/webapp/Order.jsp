<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 50px;
            background-color: white;
            padding: 20px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        table {
            margin: 20px 0;
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
            color: #555;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .total {
            font-size: 1.5em;
            margin-top: 30px;
            font-weight: bold;
        }
        .btn {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            display: inline-block;
        }
        .btn btn-remove{
         background-color:red;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="Home.jsp">Home</a></li>
            <li><a href="Shop.jsp">Shop</a></li>
            <li><a href="about.jsp">Aboutt</a></li>
            <li><a href="blog.jsp">Blog</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="cart.jsp" class="cart"><i class="fas fa-shopping-cart"></i></a></li>
        </ul>
    </nav>
	
	<div class="container">
        <h2>Your Order</h2>
        <c:choose>
            <c:when test="${empty sessionScope['cart-list']}">
                <p>Your cart is empty.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope['cart-list']}">
                            <tr>
                                <td>${item.name}</td>
                                <td>$${item.price}</td>
                                <td>${item.quantity}</td>
                                <td>$${item.quantity * Double.parseDouble(item.price)}</td>
                                <td><a href="RemoveFromCartServlet?id=${item.id}" style="background-color:red;" class="btn btn-remove">Remove</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="total">
                    <strong>Grand Total: $${sessionScope['grandTotal']}</strong>
                </div>
                <div>
                    <a href="Payment.jsp" class="btn">Proceed to Payment</a>
                    <a href="Shop.jsp" class="btn">Continue Shopping</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
</body>
</html>
