<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="EstorePackage.UserDbUtil, java.util.List, EstorePackage.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employees</title>
        <link rel="stylesheet" href="css/sidebar.css">    
    <link rel="stylesheet" href="css/A_styles.css">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
    
    	       /* Center the form and heading */
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh; /* Full viewport height */
            color:#f5ebe0;
         
        }
		.form-group {
		    margin-bottom: 14px; 
		}
		form { width: 300px; 
           margin: auto; 
           padding: 40px; 
           border:5px solid #ddd; 
           border-radius: 5px; 
           margin-bottom:20px;
           background-color: #f5ebe0;
           }
   	    input,select{ 
   	    	width: 100%; 
		    padding: 10px; 
		    margin: 5px 0; 
		    border:3px solid #ddd ;
		    border-radius:7px;
		  }
		
		.btn-primary{
		  background: linear-gradient(to bottom, #0096c7, #0077b6);
		  color:white;
		  border-radius:8px;
		  border-color:#ddd;
		  transition: background-color 0.3s;
		  margin:0px 16%;
		  width:70%;
		  padding: 8px 4px;
		  }

    </style>
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
            <li><a href="#">Home</a></li>
            <li><a href="Shop.jsp">About us</a></li>
            <li><a href="#">Products</a></li>
            <li><a href="#">Blog</a></li>
            <li><a href="#">Contact</a></li>
            
             <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </nav>
 
 
 <div class="container">
	<h2 style="text-align:center">Add New Employees</h2>
	<div class="col-6 mx-auto" style="margin-top:1%" >
		<form action="AddServlet" method="post">


			<div class="form-group mb-3 row">
				Name: <input type="text" name="name" placeholder="Enter your name" class="form-control" required>
			</div>
			
			<div class="form-group mb-2 row">
				Email: <input type="text" name="gmail" placeholder="Enter your gmail" class="form-control" required>
			</div>
			
			<div class="form-group mb-2 row">
				Phone: <input type="text" name="phone" placeholder="Enter your phone number" class="form-control" required>
			</div>
			<div class="form-group mb-2 row">
		        Role: 
		        <select name="role" class="form-control" required>
		            <option  value="admin">Admin</option>
		            <option value="customersupporter">Customer Supporter</option>
		            <option value="productmanager">Product Manager</option>
		        </select>
		    </div>
			
			<div class="form-group mb-2 row">
				Password: <input type="text" name="pw" placeholder="Enter a password" class="form-control" required>
			</div>
			<br>
			<div class="form-group mb-2 row">
				<input type="Submit" name="submit" value="Add" class="btn btn-primary">
			</div>
		</form>
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
