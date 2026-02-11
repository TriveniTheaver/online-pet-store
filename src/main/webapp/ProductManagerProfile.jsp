<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="UserPackage.SessionUtil" %>
<%@ page import="EstorePackage.ProductDAO" %>
<%@ page import="EstorePackage.ProductModel" %>
<%@ page import="java.util.List" %>
<%
	HttpSession sessionUser = request.getSession(false);
	if (sessionUser == null || sessionUser.getAttribute("userEmail") == null) {
	    response.sendRedirect("Home.jsp");
	}	
	if (!SessionUtil.validateRole(request, response, "productmanager")) {
		    return;
		}	
%>
<%
	
    
    ProductDAO Product = new ProductDAO();
    int totalProducts = Product.getTotalProductCount();
    int outOfStockProducts = Product.getOutOfStockCount(); 
    int lowStockProducts = Product.getLowStockCount(5); // Threshold of 5 items
    
    // Get filtered lists based on request parameters
    String filter = request.getParameter("filter");
    List<ProductModel> productList = null;
    
    if ("out".equals(filter)) {
        productList = Product.getOutOfStockProducts();
    } else if ("low".equals(filter)) {
        productList = Product.getLowStockProducts(5);
    } else if ("all".equals(filter)) {
        productList = Product.getAllProduct();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Manager Dashboard</title>
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&family=Montserrat:wght@700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary: #4361ee;
        --secondary: #3a0ca3;
        --accent: #4cc9f0;
        --dark: #14213d;
        --light: #f8f9fa;
        --success: #2ecc71;
        --warning: #f39c12;
        --danger: #e74c3c;
        --luxury-gold: #d4af37;
        --luxury-brown: #8B6B4D; /* New cool brown color */
        --brown-light: #A78A6F;
        --brown-dark: #5D4B36;
        --luxury-purple: #5e35b1;
    }
    
    * {
        margin: 0px;
        padding: 0;
        box-sizing: border-box;
    }
    

    
    .main-content {
        padding: 2rem 5%;
        position: relative;
    }
    
    h1 {
        font-family: 'Montserrat', sans-serif;
        font-size: 1.8rem;
        margin-bottom: 1.5rem;
        text-align: center;
        color: var(--brown-dark);
    }
    
    .dashboard-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
    }
    
    .dashboard-card {
        background: linear-gradient(145deg, #ffffff, #f8f6f2);
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        cursor: pointer;
        position: relative;
        overflow: hidden;
        border: 2px solid transparent;
        background-clip: padding-box;
    }
  
	    
			 /* Top border for all cards */
		.dashboard-card::after {
		    content: '';
		    position: absolute;
		    top: 0;
		    right: 0;
		    width: 100%;
		    height: 4px;
		    background:#5e35b1
		    border-radius: 12px 12px 0 0;
		    z-index: 1;
		}
	
    .dashboard-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }
    
    .card-icon {
        font-size: 1.8rem;
        margin-bottom: 0.8rem;
    }
    
    .card-value {
        font-size: 1.8rem;
        font-weight: 700;
        margin: 0.5rem 0;
        font-family: 'Montserrat', sans-serif;
    }
    
    .card-label {
        font-size: 0.9rem;
        color: #666;
        margin-bottom: 1rem;
    }
    .dashboard-card a {
        
        border: 1px solid var(--luxury-brown);
        position: relative;
        overflow: hidden;
    }
    .dashboard-card a {
        display: inline-block;
        padding: 0.4rem 1.2rem;
       background: linear-gradient(90deg, #5e3a87, #7d5aa6, #4c2f6f);
       
        color: white;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 500;
        font-size: 0.85rem;
        transition: all 0.3s ease;
        box-shadow: 0 2px 10px rgba(139, 107, 77, 0.2);
    }
    
    .dashboard-card:hover a {
        background: background: linear-gradient(90deg, #4b006e, #7e3a9e, #a96ed7);
        
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(139, 107, 77, 0.3);
    }
    /* Card specific border accents */
    .card-total::after,
	.card-total::before {
	    background: linear-gradient(45deg, var(--primary), var(--secondary));
	}
	
	.card-out::after,
	.card-out::before {
	    background: linear-gradient(45deg, var(--danger), #c0392b);
	}
	
	.card-low::after,
	.card-low::before {
	    background: linear-gradient(45deg, var(--warning), #e67e22);
	}
	
	.card-view::after,
	.card-view::before {
	    background: linear-gradient(45deg, var(--success), #27ae60);
	}
	    
    /* Card specific colors */
    .card-total .card-icon { color: var(--primary); }
    .card-total .card-value { color: var(--primary); }
    
    .card-out .card-icon { color: var(--danger); }
    .card-out .card-value { color: var(--danger); }
    
    .card-low .card-icon { color: var(--warning); }
    .card-low .card-value { color: var(--warning); }
    
    .card-view .card-icon { color: var(--success); }
    .card-view .card-value { color: var(--success); }
    
    /* Product List Styles */
    .product-list-container {
        margin-top: 2rem;
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    
    .product-list-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1rem;
        padding-bottom: 1rem;
        border-bottom: 1px solid #eee;
    }
    
    .product-list-header h2 {
        font-family: 'Montserrat', sans-serif;
        font-size: 1.3rem;
        color: var(--brown-dark);
    }
    
    .back-btn {
        display: inline-block;
        padding: 0.4rem 1.2rem;
        background: linear-gradient(90deg, #4b006e, #7e3a9e, #a96ed7);
        
        color: white;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 500;
        font-size: 0.85rem;
        transition: all 0.3s ease;
    }
    
    
    
    /* Compact Product Grid with fixed image sizing */
    .product-list {
        display: grid;
       grid-template-columns: repeat(5, minmax(180px, 1fr));
        gap: 1.2rem;
    }
    
    .product-card {
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        border: 1px solid #f0f0f0;
    }
    
    .product-image {
        height: 120px;
        width: 100%;
        overflow: hidden;
        background: #f5f5f5;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .product-image img {
        width: 100%;
        height: 100%;
        object-fit: contain; 
        padding: 10px; /* Add some padding around the image */
    }
    
    .product-details {
        padding: 0.8rem;
    }
    
    .product-title {
        font-weight: 600;
        margin-bottom: 0.3rem;
        color: var(--dark);
        font-size: 0.9rem;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .product-category {
        display: inline-block;
        background: #f0f0f0;
        padding: 0.2rem 0.6rem;
        border-radius: 50px;
        font-size: 0.7rem;
        margin-bottom: 0.4rem;
        color: #666;
    }
    
    .product-price {
        font-weight: 700;
        color: var(--luxury-brown);
        margin-bottom: 0.4rem;
        font-size: 0.9rem;
    }
    
    .product-stock {
        display: flex;
        align-items: center;
        margin-bottom: 0.5rem;
        font-size: 0.8rem;
    }
    
    .stock-label {
        font-weight: 500;
        margin-right: 0.3rem;
    }
    
    .stock-value {
        font-weight: 600;
    }
    
    .stock-out {
        color: var(--danger);
    }
    
    .stock-low {
        color: var(--warning);
    }
    
    .stock-available {
        color: var(--success);
    }
    
    
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .navbar {
            flex-direction: column;
            padding: 1rem;
        }
        
        .nav-links {
            margin-top: 1rem;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .dashboard-container {
            grid-template-columns: 1fr 1fr;
        }
        
        .product-list {
            grid-template-columns: 1fr 1fr;
        }
    }
	    @media (max-width: 1200px) {
	        .product-list {
	            grid-template-columns: repeat(4, minmax(180px, 1fr));
	        }
	    }
	
	    @media (max-width: 992px) {
	        .product-list {
	            grid-template-columns: repeat(3, minmax(180px, 1fr));
	        }
	    }
	
	    @media (max-width: 768px) {
	        .product-list {
	            grid-template-columns: repeat(2, minmax(180px, 1fr));
	        }
	    }
	
	    @media (max-width: 480px) {
	        .product-list {
	            grid-template-columns: 1fr;
	        }
	    }
	    @media (max-width: 480px) {
	        .dashboard-container {
	            grid-template-columns: 1fr;
	        }
       
    }
</style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="ProductManagerProfile.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="DisplayProductDetails.jsp"><i class="fas fa-boxes"></i> Products</a></li>
            <li><a href="about.jsp"><i class="fas fa-info-circle"></i> About</a></li>
            
            <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </nav>
   
    <div class="main-content"><br>
        <h1 style="font-size: 24px; color: #fef3c7; text-shadow: 1px 1px 0 #000, 2px 2px 0 #000, 3px 3px 0 #000;">
  		<center>Welcome to Product Manager Dashboard</center>
		</h1> <br><br>
        <div class="dashboard-container">
            <div class="dashboard-card card-total">
                <div class="card-icon"><i class="fas fa-box-open"></i></div>
                <div class="card-value"><%= totalProducts %></div>
                <div class="card-label">Total Products</div>
                <a href="ProductManagerProfile.jsp?filter=all">View All</a>
            </div>
            
            <div class="dashboard-card card-out">
                <div class="card-icon"><i class="fas fa-exclamation-triangle"></i></div>
                <div class="card-value"><%= outOfStockProducts %></div>
                <div class="card-label">Out of Stock</div>
                <a href="ProductManagerProfile.jsp?filter=out">View List</a>
            </div>
            
            <div class="dashboard-card card-low">
                <div class="card-icon"><i class="fas fa-battery-quarter"></i></div>
                <div class="card-value"><%= lowStockProducts %></div>
                <div class="card-label">Low Stock</div>
                <a href="ProductManagerProfile.jsp?filter=low">View List</a>
            </div>
            
            <div class="dashboard-card card-view">
                <div class="card-icon"><i class="fas fa-edit"></i></div>
                <div class="card-value">Manage</div>
                <div class="card-label">All Products</div>
                <a href="DisplayProductDetails.jsp">Edit Products</a>
            </div>
        </div>
        
        <% if (productList != null && !productList.isEmpty()) { %>
            <div class="product-list-container">
                <div class="product-list-header">
                    <h2>
                        <% if ("out".equals(filter)) { %>
                            Out of Stock (<%= outOfStockProducts %>)
                        <% } else if ("low".equals(filter)) { %>
                            Low Stock (<%= lowStockProducts %>)
                        <% } else { %>
                            All Products (<%= totalProducts %>)
                        <% } %>
                    </h2>
                    <a href="ProductManagerProfile.jsp" class="back-btn">
                        <i class="fas fa-arrow-left"></i> Close
                    </a>
                </div>
                
                <div class="product-list">
                    <% for (ProductModel product : productList) { 
                        String stockClass = "";
                        String stockText = "";
                        if (product.getQuantity() <= 0) {
                            stockClass = "stock-out";
                            stockText = "Out of Stock";
                        } else if (product.getQuantity() <= 5) {
                            stockClass = "stock-low";
                            stockText = "Low (" + product.getQuantity() + ")";
                        } else {
                            stockClass = "stock-available";
                            stockText = "In Stock (" + product.getQuantity() + ")";
                        }
                    %>
                        <div class="product-card">
                            <div class="product-image">
                                <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                                    <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                                <% } else { %>
                                    <i class="fas fa-box-open" style="font-size: 2rem; color: #ccc;"></i>
                                <% } %>
                            </div>
                            <div class="product-details">
                                <h3 class="product-title"><%= product.getName() %></h3>
                                <span class="product-category"><%= product.getCategory() %></span>
                                <div class="product-price">$<%= product.getPrice() %></div>
                                <div class="product-stock">
                                    <span class="stock-label">Stock:</span>
                                    <span class="stock-value <%= stockClass %>"><%= stockText %></span>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        <% } %>
    </div>
    
    <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p><br>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </footer>
</body>
</html>