<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="EstorePackage.InquiryModel" %>
<%@ page import="UserPackage.SessionUtil" %>

<% 
if (!SessionUtil.validateRole(request, response, "customer")) {
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Inquiry</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        :root {
            --primary-color: #3498db;
            --primary-hover: #2980b9;
            --danger-color: #e74c3c;
            --border-color: #ddd;
            --text-color: #333;
            --light-bg: #f5f5f5;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
            margin: 0;
            padding: 20px;
            color: var(--text-color);
        }
        
        .container {
            width: 700px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
            font-size: 24px;
        }
        
        .form-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .form-table tr {
            border-bottom: 1px solid var(--border-color);
        }
        
        .form-table tr:last-child {
            border-bottom: none;
        }
        
        .form-table td {
            padding: 15px 8px;
            vertical-align: middle;
        }
        
        .form-table td:first-child {
            font-weight: 600;
            width: 30%;
            color: #555;
        }
        
        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        textarea {
            height: 150px;
            resize: vertical;
        }
        
        input[type="text"]:focus,
        textarea:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(52,152,219,0.2);
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
            text-align: center;
            text-decoration: none;
            border: none;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-1px);
        }
        
        .form-actions {
            text-align: center;
            margin-top: 20px;
        }
        
        .required:after {
            content: " *";
            color: var(--danger-color);
        }
        
        .form-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .back-link {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 14px;
        }
        
        .back-link:hover {
            text-decoration: underline;
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
            color: #2ecc71;
            border-left: 4px solid #2ecc71;
        }
        
        .alert-error {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-header">
            <h1>Edit Inquiry</h1>
            <a href="CustomerInquiryServlet" class="back-link">← Back to Inquiries</a>
        </div>
        
        <% if (request.getParameter("updateError") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> Error updating inquiry. Please try again.
            </div>
        <% } %>
        <% if (request.getParameter("error") != null && request.getParameter("error").equals("empty_fields")) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> Please fill in all required fields.
            </div>
        <% } %>
        
        <c:choose>
            <c:when test="${empty inquiry}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> Inquiry not found.
                </div>
            </c:when>
            <c:otherwise>
                <form action="EditInquiryServlet" method="post">
                    <input type="hidden" name="id" value="${inquiry.id}">
                    
                    <table class="form-table">
                        <tr>
                            <td>Inquiry ID:</td>
                            <td><input type="text" value="${inquiry.id}" readonly></td>
                        </tr>
                        <tr>
                            <td class="required">Subject:</td>
                            <td><input type="text" name="subject" value="${inquiry.subject}" required></td>
                        </tr>
                        <tr>
                            <td class="required">Message:</td>
                            <td><textarea name="message" required>${inquiry.message}</textarea></td>
                        </tr>
                        <tr>
                            <td>Status:</td>
                            <td>
                                <input type="text" value="${inquiry.status}" readonly>
                            </td>
                        </tr>
                    </table>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Update Inquiry</button>
                        <a href="CustomerInquiryServlet" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>