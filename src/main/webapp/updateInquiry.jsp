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
            --accent-color: #e74c3c;
            --success-color: #2ecc71;
            --text-color: #333;
            --light-text: #777;
            --border-color: #ddd;
            --white: #fff;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 0;
           
        }
        
        .container {
            width: 800px;
            
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
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        h3 {
            color: var(--primary-color);
            margin: 1.5rem 0 1rem;
        }
        
        .inquiry-details {
            background-color: var(--secondary-color);
            padding: 1.5rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
        }
        
        .inquiry-details p {
            margin-bottom: 0.5rem;
        }
        
        .inquiry-details strong {
            color: var(--primary-color);
        }
        
        .old-response {
            background-color: rgba(176, 138, 108, 0.1);
            border-left: 4px solid var(--primary-color);
            padding: 1rem;
            margin: 1.5rem 0;
            border-radius: 0 4px 4px 0;
        }
        
        .old-response h4 {
            color: var(--primary-color);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .old-response small {
            display: block;
            text-align: right;
            color: var(--light-text);
            font-size: 0.8rem;
            margin-top: 0.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--primary-color);
        }
        
        .response-textarea {
            width: 100%;
            height: 150px;
            padding: 12px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-family: inherit;
            resize: vertical;
            transition: border-color 0.3s;
        }
        
        .response-textarea:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        
        .status-select {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-family: inherit;
            background-color: var(--white);
            color: var(--text-color);
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
        }
        
        .btn-primary:hover {
            background-color: #9c7860;
            transform: translateY(-1px);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: var(--white);
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-1px);
        }
        
        .alert {
            padding: 12px 15px;
            margin-bottom: 1.5rem;
            border-radius: 5px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }
        
        .alert-error {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--accent-color);
            border-left: 4px solid var(--accent-color);
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
                margin: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-reply"></i> Respond to Inquiry</h1>
        
        <c:if test="${not empty param.responseSuccess}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Response submitted successfully!
            </div>
        </c:if>
        <c:if test="${not empty param.responseError}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> ${not empty param.message ? param.message : 'Error submitting response'}
            </div>
        </c:if>
        
        <div class="inquiry-details">
            <h3><i class="fas fa-info-circle"></i> Inquiry Details</h3>
            <p><strong><i class="fas fa-heading"></i> Subject:</strong> ${inquiry.subject}</p>
            <p><strong><i class="fas fa-envelope"></i> Message:</strong> ${inquiry.message}</p>
            <p><strong><i class="fas fa-tag"></i> Status:</strong> ${inquiry.status}</p>
            <p><strong><i class="fas fa-calendar-alt"></i> Date:</strong> ${inquiry.createdAt}</p>
            
            <c:if test="${not empty inquiry.response}">
                <div class="old-response">
                    <h4><i class="fas fa-history"></i> Previous Response</h4>
                    <p>${inquiry.response}</p>
                    <small><i class="fas fa-clock"></i> ${inquiry.responseDate}</small>
                </div>
            </c:if>
        </div>
        
        <form action="UpdateInquiryServlet" method="post">
            <input type="hidden" name="id" value="${inquiry.id}">
            
            <div class="form-group">
                <label for="response"><i class="fas fa-comment-dots"></i> Your Response</label>
                <textarea id="response" name="response" class="response-textarea" required>${inquiry.response}</textarea>
            </div>
            
            <div class="form-group">
                <label for="status"><i class="fas fa-sync-alt"></i> Update Status</label>
                <select id="status" name="status" class="status-select">
                    <option value="Open" ${inquiry.status == 'Open' ? 'selected' : ''}>Open</option>
                    <option value="In Progress" ${inquiry.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
                    <option value="Resolved" ${inquiry.status == 'Resolved' ? 'selected' : ''}>Resolved</option>
                    <option value="Closed" ${inquiry.status == 'Closed' ? 'selected' : ''}>Closed</option>
                </select>
            </div>
            
            <div style="display: flex; gap: 10px;">
                <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Submit Response</button>
                <a href="InquiryGetAllServlet" class="btn btn-secondary"><i class="fas fa-times"></i> Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>