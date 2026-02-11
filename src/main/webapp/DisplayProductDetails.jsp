<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="UserPackage.SessionUtil" %>
<% 
if (!SessionUtil.validateRole(request, response, "productmanager")) {
    return;
}

// Redirect to the servlet if allProducts attribute is not set
if (request.getAttribute("allProducts") == null) {
    response.sendRedirect("ProductGetAllServlet");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management | MyPetStore</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        :root {
            --primary-color: #b08a6c;
            --secondary-color: #f8f1e9;
            --dark-color: #3a3226;
            --light-color: #ffffff;
            --danger-color: #e74c3c;
            --success-color: #2ecc71;
        }
        
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .main-container {
            display: flex;
            flex: 1;
        }
        
        .main-content {
            flex: 1;
            padding: 20px;
            display: flex;
            justify-content: center;
        }
        
        .content-wrapper {
            width: 100%;
            max-width: 1000px;
        }
        
        .transparent-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin: 20px 0;
            color: var(--dark-color);
        }
        
        h2 {
            color: var(--dark-color);
            margin-bottom: 25px;
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
            text-align: center;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px auto;
            font-size: 1.01em;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        
        table th, table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #dddddd;
        }
        
        table th {
            background-color: var(--primary-color);
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.1em;
        }
        
        table tr:nth-child(even) {
            background-color: var(--secondary-color);
        }
        
        table tr:hover {
            background-color: rgba(176, 138, 108, 0.1);
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none !important;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #9a755a;
            transform: translateY(-2px);
        }
        
        .btn-edit {
            background-color: #3498db;
            color: white;
        }
        
        .btn-edit:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        
        .btn-delete {
            background-color: var(--danger-color);
            color: white;
        }
        
        .btn-delete:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
        }
        
        .btn i {
            margin-right: 5px;
        }
        
        .no-products {
            text-align: center;
            padding: 20px;
            color: var(--danger-color);
            font-weight: bold;
        }
        
        .add-product-container {
            text-align: center;
            margin-top: 20px;
        }
        table th:not(:last-child),
	   
	
	    table thead tr {
	        border-bottom: 2px solid rgba(0, 0, 0, 0.1);
	    }
	
	    table tbody tr:not(:last-child) {
	        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
	    }
        
        @media (max-width: 768px) {
            .transparent-container {
                padding: 15px;
            }
            
            table {
                display: block;
                overflow-x: auto;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="ProductManagerProfile.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="DisplayProductDetails.jsp"><i class="fas fa-boxes"></i> Products</a></li>
            <li><a href="about.jsp"><i class="fas fa-info-circle"></i> About</a></li>
            
            <li><a href="LogoutServlet"> <i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </nav>
    
    <div class="main-container">
        <div class="main-content">
            <div class="content-wrapper">
                <div class="transparent-container">
                    <h2><i class="fas fa-boxes"></i> Product Management</h2>
                    
                    <c:if test="${empty allProducts}">
                        <div class="no-products">
                            <i class="fas fa-exclamation-circle"></i> No products found in the database!
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty allProducts}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Price</th>
                                    <th>Category</th>
                                    <th>Quantity</th>
                                    <th>Description</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${allProducts}">
                                <tr>
                                    <td>
                                        <img src="${product.imageUrl}" alt="${product.name}" class="product-image">
                                    </td>
                                    <td>${product.id}</td>
                                    <td>${product.name}</td>
                                    <td>$${product.price}</td>
                                    <td>${product.category}</td>
                                    <td>${product.quantity}</td>
                                    <td>${product.description}</td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="UpdateProduct.jsp?id=${product.id}&name=${product.name}&price=${product.price}&category=${product.category}&quantity=${product.quantity}&description=${product.description}&imageUrl=${product.imageUrl}" 
                                               class="btn btn-edit">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <form action="ProductDeleteServlet" method="post" style="display: inline;" 
											      onsubmit="return confirm('Are you sure you want to delete this product?');">
											    <input type="hidden" name="id" value="${product.id}"/>
											    <button type="submit" class="btn btn-delete">
											        <i class="fas fa-trash-alt"></i> Delete
											    </button>
											</form>
                                            
                                        </div>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    
                    <div class="add-product-container">
                        <a href="addProduct.jsp" class="btn btn-primary">
                            <i class="fas fa-plus-circle"></i> Add New Product
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </footer>
</body>
</html>