<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group select,
        .form-group input {
            width: 98%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            color: #333;
        }

        .form-group select:focus,
        .form-group input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        /* Button Styles */
        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .btn:active {
            background-color: #004080;
        }

        /* Link Styles */
        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="Shop.jsp">Shop</a></li>
            <li><a href="Order.jsp">Order</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="blog.jsp">Blog</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="cart.jsp" class="cart"><i class="fas fa-shopping-cart"></i></a></li>
            <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </nav>
    <div class="container">
        <h2>Payment</h2>
        <form action="ConfirmOrderServlet" method="post">
            <!-- Payment Method -->
            <div class="form-group">
                <label for="paymentMethod">Select Payment Method:</label>
                <select id="paymentMethod" name="paymentMethod" required>
                    <option value="creditCard">Credit Card</option>
                    <option value="paypal">PayPal</option>
                    <option value="cashOnDelivery">Cash on Delivery</option>
                </select>
            </div>

            <!-- Payment Details -->
            <div class="form-group">
                <label for="cardNumber">Card Number (if Credit Card):</label>
                <input type="text" id="cardNumber" name="cardNumber" placeholder="Enter card number">
            </div>

            <div class="form-group">
                <label for="expiryDate">Expiry Date (if Credit Card):</label>
                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY">
            </div>

            <div class="form-group">
                <label for="cvv">CVV (if Credit Card):</label>
                <input type="text" id="cvv" name="cvv" placeholder="Enter CVV">
            </div>

            <!-- Confirm Button -->
            <button type="submit" class="btn">Confirm Order</button>
        </form>

        <!-- Back to Cart Link -->
        <a href="Cart.jsp" class="back-link">Back to Cart</a>
    </div>
</body>
</html>