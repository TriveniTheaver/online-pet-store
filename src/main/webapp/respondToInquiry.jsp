<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("userEmail") == null) {
        response.sendRedirect("Login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Respond to Inquiry</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #b08a6c;
            --secondary-color: #f8f1e9;
            --success-color: #2ecc71;
            --text-color: #333;
            --border-color: #ddd;
            --white: #fff;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
            color: var(--text-color);
            line-height: 1.6;
            padding: 0;
            margin: 0;
        }
        
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: var(--white);
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
        }
        
        h1 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 0.5rem;
        }
        
        .inquiry-details {
            background-color: var(--secondary-color);
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1.5rem;
        }
        
        .detail-row {
            margin-bottom: 0.5rem;
        }
        
        .detail-label {
            font-weight: 500;
            display: inline-block;
            width: 100px;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        textarea {
            width: 100%;
            height: 200px;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            resize: vertical;
            font-family: inherit;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background-color: var(--success-color);
            color: var(--white);
        }
        
        .btn-primary:hover {
            background-color: #27ae60;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: var(--white);
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        
        .alert {
            padding: 12px 15px;
            margin-bottom: 1.5rem;
            border-radius: 5px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }
        
        .alert i {
            margin-right: 10px;
        }
        
        .alert-success {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }
        
        .alert-error {
            background-color: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            border-left: 4px solid #e74c3c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-reply"></i> Respond to Inquiry</h1>
        
        <% if (request.getParameter("responseSuccess") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Response added successfully!
            </div>
        <% } %>
        <% if (request.getParameter("responseError") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> Error adding response. Please try again.
            </div>
        <% } %>
        
        <div class="inquiry-details">
            <div class="detail-row">
                <span class="detail-label">ID:</span>
                <span>${inquiry.id}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Customer:</span>
                <span>${inquiry.customerId}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Subject:</span>
                <span>${inquiry.subject}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Message:</span>
                <span>${inquiry.message}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Status:</span>
                <span>${inquiry.status}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Date:</span>
                <span>${inquiry.createdAt}</span>
            </div>
        </div>
        
        <form action="AddResponseServlet" method="post">
            <input type="hidden" name="id" value="${inquiry.id}">
            
            <div class="form-group">
                <label for="response">Your Response</label>
                <textarea id="response" name="response" placeholder="Enter your detailed response here..." required></textarea>
            </div>
            
            <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Submit Response</button>
            <a href="InquiryGetAllServlet" class="btn btn-secondary"><i class="fas fa-times"></i> Cancel</a>
        </form>
    </div>
</body>
</html>