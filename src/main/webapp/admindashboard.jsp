<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="UserPackage.SessionUtil" %>
<%

 
if (!SessionUtil.validateRole(request, response, "admin")) {
    return;
}
%>
<html>
<head>
    <title>PetStore Admin Dashboard</title>
    <link rel="stylesheet" href="css/admin-styles.css">
    <link rel="stylesheet" href="css/sidebar.css">    
    <link rel="stylesheet" href="css/A_styles.css">
    <link rel="stylesheet" href="css/styles.css">
	
	<style>
		.dashcontent{
			padding-left:150px;
			padding-right:150px;
			padding-top:60px;
		}
	</style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<!-- SIDEBAR -->
    <button class="toggle-btn" onclick="toggleSidebar()"> <i class="fas fa-paw"></i></button>

    <div class="sidebar">
    	<a href="DashboardServlet" class="dashboard-link"><i class="fas fa-th"></i> Dashboard</a>
        <a href="manageusers.jsp">Manage Users</a>
        
      
    </div>

    <script>
        function toggleSidebar() {
            document.body.classList.toggle('sidebar-open');
        }
    </script>
    
 <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="Home.jsp">Home</a></li>
            <li><a href="about.jsp">About us</a></li>
            <li><a href="Shop.jsp">Products</a></li>
            <li><a href="blog.jsp">Blog</a></li>
            <li><a href="contact.jsp">Contact</a></li>

            <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </nav>
    

  <div class="dashcontent"> 
 <!-- content -->  
    <div class="dashboard-header">
        <h1 style="text-align:center">Welcome to Admin Dashboard</h1>
    </div>



		 <div class="stats-container">
			<div class="stat-card sales-card">
                <h2><i class="fas fa-dollar-sign"></i> Monthly Sales</h2>
                <div class="value">$${monthlySales}</div>
                <div class="subtext">Total sales this month</div>
            </div>
			 	
			 
            <div class="stat-card users-card">
                <h2><i class="fas fa-users"></i> Total Customers</h2>
                <div class="value">${userCount}</div>
                <div class="subtext">Registered pet owners</div>
            </div>

            <div class="stat-card employees-card">
                <h2><i class="fas fa-user-tie"></i> Total Employees</h2>
                <div class="value">${employeeCount}</div>
                <div class="subtext">Store team members</div>
            </div>
</div>

    <!-- Today's Activity Section -->
    <div class="todays-activity" >
    <div class="dashboard-header">
        <h2 style="color:#f5ebe0;"><i class="fas fa-calendar-day" ></i> Today's Activity</h2>
    </div>
        
        <div class="today-stats-container">
            <div class="today-stat-card new-orders-card">
                <h3><i class="fas fa-shopping-cart"></i> Pending Orders</h3>
                <div class="value">${pendingOrdersCount}</div>
                <div class="subtext">Pending purchases</div>
            </div>
            
            <div class="today-stat-card sales-card">
                <h3><i class="fas fa-dollar-sign"></i> Today's Sales</h3>
                <div class="value">$${todaysSales}</div>
                <div class="subtext">Total revenue</div>
            </div>
            
            <div class="today-stat-card new-queries-card">
                <h3><i class="fas fa-question-circle"></i>Pending Queries</h3>
                <div class="value">${openQueriesCount}</div>
                <div class="subtext">Customer questions</div>
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