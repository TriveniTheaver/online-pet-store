<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="EstorePackage.UserDbUtil, java.util.List, EstorePackage.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
        <link rel="stylesheet" href="css/sidebar.css">    
    <link rel="stylesheet" href="css/A_styles.css">
    <link rel="stylesheet" href="css/styles.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
     
     <style>
			     	/* General Styling */
			body {
			    font-family: Arial, sans-serif;
			    margin: 0;
			    padding: 0;
			    background-color: #f5ebe0; /* Warm off-white background */
			    color: color: #5a4638;; /* Dark brown text */
			    display: flex;
			    flex-direction: column;
			    min-height: 100vh; /* Full viewport height */
			}
			
			/* Table Container */
			.table-container {
			    position: relative;
			    width: 80%;
			    margin: 20px auto;
			    padding: 20px;
			    background-color: white; /* White background for the table container */
			    border-radius: 16px;
			    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Subtle shadow */
			}
			
			/* Table Styling */
			table {
			    width: 100%;
			    border-collapse: collapse;
			    margin-top: 10px;
			    border-radius: 16px;
			    overflow: hidden;
			    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			  
			}
			
			th {
			   /*   background-color: #6d8b74; Soft green */
			    /*background: linear-gradient(to bottom, #007BFF, #0056b3);*/
			     background: linear-gradient(to bottom, #6d8b74, #5a7261);
			    color: white;
			    padding: 12px;
			    text-align: center;
			}
			
			td {
			    border: 1px solid rgba(0, 0, 0, 0.1);
			    padding: 12px;
			    text-align: center;
			    color: #5a4638; /* Dark brown text */
			}
			.etr th{
			background: linear-gradient(to bottom, #0096c7, #0077b6);
			}
			tr:hover {
			    background-color: rgba(109, 139, 116, 0.1); /* Soft green with 10% opacity */
			}
			
			
			/* Buttons */
			.btn {
			    padding: 8px 12px;
			    border: none;
			    border-radius: 20px;
			    cursor: pointer;
			    color: white;
			    font-size: 14px;
			    transition: background-color 0.3s;
			}
			/* Add Button */
			.add-btn {
			   
			    background: linear-gradient(to bottom, #0096c7, #0077b6);
			    color: white;
			    transition: background-color 0.3s;
			    padding: 9px 16px;
			    border: none;
			    border-radius: 20px;
			    cursor: pointer;
			}
			
			.add-btn:hover {
			    background-color:#00b4d8; 
			}
			
			.update-btn {
			 background: linear-gradient(to bottom, #88c099, #6da57a); 
			
			  /*  background-color: #88c099; */
			}
			
			.update-btn:hover {
			    background-color: #6ba58c; 
			}
			
			.delete-btn {
				background: linear-gradient(to bottom, #ff6b6b, #ff4757); /* Gradient using #ff6b6b */
			   /* background-color: #ff6b6b; */
			}
			
			.delete-btn:hover {
			    background-color:  #e63946; 
			}




     </style>
</head>
<body>

<!-- 
			SIDEBAR 
 -->
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
    
<h2 style="text-align:center">Manage Users</h2>


<%
    List<User> userList = UserDbUtil.getAllUsers();
    request.setAttribute("users", userList);//passing userlist object to users
%>

<div class="table-container">
    <div class="add">
        <a href="addnewUser.jsp"><button class="btn add-btn">Add New User</button></a>
    </div>
    <table>
        <tr class="etr">
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Password</th>
            <th>Phone</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.gmail}</td>
                <td>${user.password}</td>
                <td>${user.phone}</td>
                <td>${user.role}</td>
                <td>
                    <a href="updateUser.jsp?id=${user.id}&name=${user.name}&gmail=${user.gmail}&ps=${user.password}&phone=${user.phone}&role=${user.role}">
    					<button class="btn update-btn">Update</button></a>
    					
                    <button class="btn delete-btn" onclick="confirmDelete(${user.id})">Delete</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<!-- ---------------------------------------Employees-------------------------------------- -->

<%
    List<User> emplist = UserDbUtil.getAllEmployees();
    request.setAttribute("emps", emplist);//passing userlist object to users
%>
<div class="table-container">
    <div class="add">
        <a href="addnewEmp.jsp">
        <button class="btn add-btn" style=" background: linear-gradient(to bottom, #6d8b74, #5a7261)">Add New Employee</button>
        </a>
    </div>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Password</th>
            <th>Phone</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="emp" items="${emps}">
            <tr>
                <td>${emp.id}</td>
                <td>${emp.name}</td>
                <td>${emp.gmail}</td>
                <td>${emp.password}</td>
                <td>${emp.phone}</td>
                <td>${emp.role}</td>
                <td>
                    <a href="updateUser.jsp?id=${emp.id}&name=${emp.name}&gmail=${emp.gmail}&ps=${emp.password}&phone=${emp.phone}&role=${emp.role}">
    					<button class="btn update-btn">Update</button></a>
    					
                    <button class="btn delete-btn" onclick="confirmDelete(${emp.id})">Delete</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<script>
    function confirmDelete(userId) {
        if (confirm("Are you sure you want to delete this user?")) {
            window.location.href = "DeleteUserServlet?id=" + userId;
        }
    }
</script>

		
		
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
