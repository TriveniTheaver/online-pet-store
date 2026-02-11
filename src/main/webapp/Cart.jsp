<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="EstorePackage.CartModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="css/styles.css">
    <script>
    function updateQuantity(productId, change) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "UpdateCartQuantityServlet?id=" + productId + "&change=" + change, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = xhr.responseText.trim();
                if (response === "Insufficient Stock") {
                    alert("Insufficient Stock: Not enough stock available.");
                } else if (response === "Quantity cannot be less than 1") {
                    alert("Quantity cannot be less than 1.");
                } else {
                    location.reload(); // Reload the page to reflect the updated quantity
                }
            }
        };
        xhr.send();
    }
</script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        tr:hover {
            background-color: #f1f1f1;
        }
        .total {
            font-size: 1.5em;
            margin: 20px;
            font-weight: bold;
        }
        .btn {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #218838;
        }
        .btn-remove {
            background-color: #dc3545;
        }
        .btn-remove:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

	<!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="Shop.jsp">Shop</a></li>
            <li><a href="Order.jsp">Order</a></li>
            <li><a href="#">Adopt</a></li>
            <li><a href="#">Blog</a></li>
            <li><a href="#">Contact</a></li>
            <li><a href="#" class="cart"><i class="fas fa-shopping-cart"></i></a></li>
            
        </ul>
    </nav>
     <div class="container">
        <h2>Your Shopping Cart</h2>
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
                               <td>
   									 <button onclick="updateQuantity(${item.id}, -1)">-</button>
    								${item.quantity}
    								<button onclick="updateQuantity(${item.id}, 1)">+</button>
								</td>
                                <td>$${item.quantity * Double.parseDouble(item.price)}</td>
                                <td><a href="RemoveFromCartServlet?id=${item.id}" class="btn btn-remove">Remove</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="total">
                    <strong>Grand Total: $${sessionScope['grandTotal']}</strong>
                </div>
                <div>
                    <a href="Order.jsp" class="btn">Proceed to Checkout</a>
                    <a href="Shop.jsp" class="btn">Continue Shopping</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
