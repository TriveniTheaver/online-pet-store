<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="UserPackage.SessionUtil" %>
<%@ page import="UserPackage.SessionUtil" %>
<% 
if (!SessionUtil.validateRole(request, response, "customer")) {
    return;
}
%>

<%
HttpSession sessionUser = request.getSession(false);
// Check for either userId or userEmail
if (sessionUser == null || 
   (sessionUser.getAttribute("userId") == null && sessionUser.getAttribute("userEmail") == null)) {
    response.sendRedirect("Home.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Dashboard</title>
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary: #ff6b6b;
        --secondary: #4ecdc4;
        --accent: #ffe66d;
        --dark: #292f36;
        --light: #f7fff7;
        --luxury-gold: #d4af37;
        --luxury-maroon: #800020;
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    
    .main-content {
        padding: 3rem 5%;
        position: relative;
    }
    
    .main-content::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: url('https://www.transparenttextures.com/patterns/paw-print.png');
        opacity: 0.05;
        z-index: -1;
    }
    
    h1 {
        font-family: 'Playfair Display', serif;
        font-size: 3rem;
        margin-bottom: 2rem;
        text-align: center;
        color: var(--luxury-maroon);
        position: relative;
        display: inline-block;
        left: 50%;
        transform: translateX(-50%);
    }
    
    h1::after {
        content: '';
        position: absolute;
        width: 50%;
        height: 4px;
        bottom: -10px;
        left: 25%;
        background: linear-gradient(90deg, var(--luxury-gold), var(--luxury-maroon));
        border-radius: 2px;
    }
    
    .dashboard-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 2rem;
        margin-top: 3rem;
    }
    
    .dashboard-card {
        background: white;
        border-radius: 15px;
        padding: 2rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        cursor: pointer;
        position: relative;
        overflow: hidden;
        z-index: 1;
        border: 1px solid rgba(255, 255, 255, 0.3);
    }
    
    .dashboard-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(212, 175, 55, 0.1) 0%, rgba(128, 0, 32, 0.1) 100%);
        z-index: -1;
    }
    
    .dashboard-card:hover {
        transform: translateY(-10px) scale(1.02);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
    }
    
    .dashboard-card h3 {
        font-size: 1.5rem;
        margin-bottom: 1rem;
        color: var(--luxury-maroon);
        position: relative;
        display: inline-block;
    }
    
    .dashboard-card h3::after {
        content: '';
        position: absolute;
        width: 50%;
        height: 2px;
        bottom: -5px;
        left: 0;
        background: var(--luxury-gold);
        transition: width 0.3s ease;
    }
    
    .dashboard-card:hover h3::after {
        width: 100%;
    }
    
    .dashboard-card p {
        color: #666;
        margin-bottom: 1.5rem;
    }
    
    .dashboard-card i {
        font-size: 2.5rem;
        color: var(--luxury-gold);
        margin-bottom: 1rem;
        transition: transform 0.3s ease;
    }
    
    .dashboard-card:hover i {
        transform: scale(1.2) rotate(10deg);
    }
    
   
    
    /* Animated paw prints decoration */
    .paw-decoration {
        position: absolute;
        opacity: 0.1;
        z-index: -1;
        animation: float 6s infinite ease-in-out;
    }
    
    @keyframes float {
        0%, 100% {
            transform: translateY(0) rotate(0deg);
        }
        50% {
            transform: translateY(-20px) rotate(5deg);
        }
    }
    
   
</style>
</head>
<body>
    <!-- Decorative paw prints -->
    <div class="paw-decoration" style="top: 15%; left: 5%; font-size: 3rem;">🐾</div>
    <div class="paw-decoration" style="top: 25%; right: 8%; font-size: 4rem;">🐾</div>
    <div class="paw-decoration" style="bottom: 20%; left: 10%; font-size: 2.5rem;">🐾</div>
    <div class="paw-decoration" style="bottom: 30%; right: 15%; font-size: 3.5rem;">🐾</div>
    
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="CustomerProfile.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="CustomerInquiryServlet"><i class="fas fa-question-circle"></i> My Inquiries</a></li>
            <li><a href="#"><i class="fas fa-paw"></i> Adopt</a></li>
            <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
            <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </nav>
    
    <div class="main-content">
        <h1 style="font-size: 24px; color: #fef3c7; text-shadow: 1px 1px 0 #000, 2px 2px 0 #000, 3px 3px 0 #000;">
  		<center>Welcome to Customer  Dashboard</center>
		</h1>
        
        <div class="dashboard-container">
            <div class="dashboard-card" onclick="window.location.href='Shop.jsp'">
                <i class="fas fa-shopping-bag"></i>
                <h3>Shop Products</h3>
                <p>Discover premium products for your beloved pets</p>
                <div class="arrow-icon"><i class="fas fa-chevron-right"></i></div>
            </div>
            
            <div class="dashboard-card" onclick="window.location.href='CustomerInquiryServlet'">
                <i class="fas fa-comments"></i>
                <h3>My Inquiries</h3>
                <p>Manage your questions and get expert advice</p>
                <div class="arrow-icon"><i class="fas fa-chevron-right"></i></div>
            </div>
            
            <div class="dashboard-card" onclick="window.location.href='OrderHistoryServlet'">
                <i class="fas fa-history"></i>
                <h3>Order History</h3>
                <p>Review your past purchases and track deliveries</p>
                <div class="arrow-icon"><i class="fas fa-chevron-right"></i></div>
            </div>
            
            
            
            
            
            
        </div>
    </div>

    <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p>
            <p style="margin-top: 0.5rem; font-size: 0.8rem;">
                <i class="fas fa-phone"></i> (123) 456-7890 | 
                <i class="fas fa-envelope"></i> contact@mypetstore.com
            </p>
        </div>
    </footer>
    
    <script>
        // Add animation to cards on page load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.dashboard-card');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>