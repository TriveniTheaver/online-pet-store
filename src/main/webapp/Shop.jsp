<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% 
// Redirect to the servlet if allProducts attribute is not set
if (request.getAttribute("allProducts") == null) {
    response.sendRedirect("DisplayProductInShopServlet");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop</title>
    <link rel="stylesheet" href="css/styles.css">
    <script>
        function addToCart(productId, productName, productPrice, productImageUrl) {
            // Create an XMLHttpRequest object
            var xhr = new XMLHttpRequest();

            // Define the request
            xhr.open("GET", "AddToCartServlet?id=" + productId + "&name=" + encodeURIComponent(productName) + "&price=" + productPrice + "&imageUrl=" + encodeURIComponent(productImageUrl), true);

            // Set up a callback function to handle the response
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = xhr.responseText.trim();
                    if (response === "Out of Stock") {
                        alert("Out of Stock: This product is no longer available.");
                    } else {
                        alert("Product added to cart!");
                        location.reload(); // Reload the page to reflect the updated stock status
                    }
                }
            };

            // Send the request
            xhr.send();
        }
        
        function filterByCategory(category) {
            // Get all product cards
            const products = document.querySelectorAll('.product-card');
            
            products.forEach(product => {
                const productCategory = product.getAttribute('data-category');
                if (category === 'all' || productCategory === category) {
                    product.style.display = 'block';
                } else {
                    product.style.display = 'none';
                }
            });
        }
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            /*background-image: url("images/l.avif");*/
        }

        /* Main Content Container */
        .main-content {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 cards per row */
            gap: 15px;  /* Further reduced gap between cards */
            padding: 10px;
        }

        /* Individual Product Card */
        .product-card {
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 6px; /* Slightly smaller border-radius */
            overflow: hidden;
            transition: transform 0.2s ease;
            padding: 25px; /* Reduced padding */
            height: 225px;
            width:200px;
            margin:40px; /* Reduced height */
        }

        .product-card:hover {
            transform: translateY(-3px);
        }

        /* Image Styling */
        .product-image {
            width: 100%;
            height: 120px;  /* Further reduced height */
            object-fit: cover;
            border-bottom: 1px solid #ddd;
        }

        /* Product Info Styling */
        .product-info {
            padding: 5px; /* Reduced padding */
            text-align: center;
        }

        .product-info h3 {
            font-size: 14px; /* Further reduced font size */
            color: #333;
            margin: 0;
        }

        .product-info p {
            font-size: 10px; /* Further reduced font size */
            color: #777;
            margin: 5px 0;
        }

        .product-info .price {
            font-size: 12px; /* Further reduced font size */
            color: #e91e63;
            font-weight: bold;
            margin-top: 5px;
        }

        /* Button Styling */
        .add-to-cart-btn {
            background-color: #d4b098;
            color: black;
            border: none;
            border-radius: 4px; /* Slightly smaller radius */
            padding: 6px 12px; /* Reduced padding */
            cursor: pointer;
            font-size: 15px; /* Further reduced font size */
            
            width: 100%;
            transition: background-color 0.3s ease;
             color: black;
        }

        .add-to-cart-btn:hover {
            background-color: #a88c6f;
             color: black;
        }

        /* No products message */
        .no-products {
            text-align: center;
            color: red;
            font-size: 14px; /* Further reduced font size */
            margin-top: 20px;
        }

        /* Responsive Media Queries */
        @media (max-width: 1024px) {
            .main-content {
                grid-template-columns: repeat(3, 1fr); /* 3 cards per row on medium screens */
            }
        }

        @media (max-width: 768px) {
            .main-content {
                grid-template-columns: repeat(2, 1fr); /* 2 cards per row on tablets */
            }
        }

        @media (max-width: 480px) {
            .main-content {
                grid-template-columns: 1fr; /* 1 card per row on small screens */
            }
        }
        .stock-status {
            font-size: 12px;
            font-weight: bold;
            margin-top: 5px;
            
        }
        .in-stock {
            color: #28a745 !important; /* Green */
        }
        
        .out-of-stock {
            color: #dc3545 !important; /* Red */
        }
        .category-filter {
            display: flex;
            justify-content: center;
            margin: 20px 0;
            flex-wrap: wrap;
            gap: 10px;
        }
        

		.category-btn {
		  padding: 12px 28px;
		  background-color: #f5f0e1;
		  color: #4b3f2f;
		  font-size: 16px;
		  font-weight: 600;
		  font-family: 'Poppins', sans-serif;
		  border: 1px solid #e0d6c5;
		  border-radius: 12px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
		  cursor: pointer;
		  transition: all 0.3s ease;
		}
		
		.category-btn:hover {
		  background-color: #ebe3d2;
		  color: #2e2417;
		  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
		  transform: translateY(-2px);
		}




        
        order-color: #d4b098;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="Home.jsp">Home</a></li>
            <li><a href="Cart.jsp">Cart</a></li>
            <li><a href="adopt.jsp">Adopt</a></li>
            <li><a href="blog.jsp">Blog</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>
    </nav>
    
    <!-- Category Filter -->
    <div class="category-filter">
        <button class="category-btn active" onclick="filterByCategory('all')">All Products</button>
        <button class="category-btn" onclick="filterByCategory('cat')">Cats</button>
        <button class="category-btn" onclick="filterByCategory('dog')">Dogs</button>
        <button class="category-btn" onclick="filterByCategory('bird')">Birds</button>
        <button class="category-btn" onclick="filterByCategory('fish')">Fish</button>
    </div>
    
    <!-- Main Content: Product Cards -->
    <div class="main-content">
        <c:choose>
            <c:when test="${empty allProducts}">
                <p class="no-products">No products found in the database!</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="product" items="${allProducts}">
                    <div class="product-card" data-category="${product.category}">
                        <img src="${product.imageUrl}" alt="Product Image" class="product-image">
                        <div class="product-info">
                            <h3>${product.name}</h3>
                            <p>${product.description}</p>
                            <p class="price">$${product.price}</p>
                            <p class="stock-status ${product.quantity > 0 ? 'in-stock' : 'out-of-stock'}">
                                ${product.quantity > 0 ? 'In Stock' : 'Out of Stock'}
                            </p>
                            <button onclick="addToCart(${product.id}, '${product.name}', '${product.price}', '${product.imageUrl}')" 
                                  class="add-to-cart-btn" ${product.quantity <= 0 ? 'disabled' : ''}>
                                ${product.quantity <= 0 ? 'Out of Stock' : 'Add to Cart 🛒'}
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p>
        </div>
    </footer>
</body>
</html>