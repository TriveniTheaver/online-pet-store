<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="UserPackage.SessionUtil" %>
<% 
if (!SessionUtil.validateRole(request, response, "customer")) {
    return;
}
%>
<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || 
       (sessionUser.getAttribute("userId") == null && sessionUser.getAttribute("userEmail") == null)) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<% if (request.getParameter("error") != null) { 
    String errorType = request.getParameter("error");
%>
    <div class="alert alert-danger">
        <strong>Error!</strong> 
        <% if ("empty".equals(errorType)) { %>
            Subject and message cannot be empty.
        <% } else if ("create".equals(errorType)) { %>
            Could not create inquiry. Please try again.
        <% } else if ("exception".equals(errorType)) { %>
            A system error occurred. Please contact support.
        <% } else { %>
            An unknown error occurred.
        <% } %>
    </div>
<% } %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Inquiry</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .form-container {
            background: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 10px;
            max-width: 600px;
            margin: 50px auto;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .form-group textarea {
            height: 150px;
        }
        .btn-submit {
            background-color: #b08a6c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="CustomerProfile.jsp">Dashboard</a></li>
            <li><a href="CustomerInquiryServlet">My Inquiries</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </nav>

    <div class="form-container">
        <h2>Create New Inquiry</h2>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">Error creating inquiry. Please try again.</div>
        <% } %>
        
        <form action="CreateInquiryServlet" method="post">
            <div class="form-group">
                <label for="subject">Subject</label>
                <input type="text" id="subject" name="subject" required>
            </div>
            
            <div class="form-group">
                <label for="message">Message</label>
                <textarea id="message" name="message" required></textarea>
            </div>
            
            <button type="submit" class="btn-submit">Submit Inquiry</button>
        </form>
    </div>
</body>
</html>