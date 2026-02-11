<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="UserPackage.SessionUtil" %>

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
    <title>Customer Inquiries</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="css/styles.css">   
    <style>
        :root {
            --primary-color: #b08a6c;
            --secondary-color: #f8f1e9;
            --accent-color: #e74c3c;
            --success-color: #2ecc71;
            --warning-color: #f39c12;
            --info-color: #3498db;
            --text-color: #333;
            --light-text: #777;
            --border-color: #ddd;
            --white: #fff;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background-color: #f5f5f5;
            color: var(--text-color);
            line-height: 1.6;
        }
        
       
       
        
        .inquiry-container {
            background: var(--white);
            padding: 2rem;
            border-radius: 8px;
            max-width: 1200px;
            margin: 2rem auto;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
        }
        
        h2 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 0.5rem;
        }
        
        .inquiry-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        
        .inquiry-table th, .inquiry-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }
        
        .inquiry-table th {
            background-color: var(--primary-color);
            color: var(--white);
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
        }
        
        .inquiry-table tr:hover {
            background-color: rgba(176, 138, 108, 0.05);
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: capitalize;
        }
        
        .status-open {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--accent-color);
        }
        
        .status-in-progress {
            background-color: rgba(243, 156, 18, 0.1);
            color: var(--warning-color);
        }
        
        .status-resolved, .status-closed {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success-color);
        }
        
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin: 2px;
            font-size: 0.8rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn i {
            margin-right: 5px;
            font-size: 0.8rem;
        }
        
        .btn-update {
            background-color: var(--info-color);
            color: var(--white);
        }
        
        .btn-update:hover {
            background-color: #2980b9;
        }
        
        .btn-respond {
            background-color: var(--success-color);
            color: var(--white);
        }
        
        .btn-respond:hover {
            background-color: #27ae60;
        }
        
        .btn-delete {
            background-color: var(--accent-color);
            color: var(--white);
        }
        
        .btn-delete:hover {
            background-color: #c0392b;
        }
        
        .btn-view {
            background-color: var(--secondary-color);
            color: var(--text-color);
        }
        
        .btn-view:hover {
            background-color: #e0d7cd;
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
            font-size: 1.1rem;
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
        
        .response-form {
            margin-top: 15px;
            display: none;
            background-color: var(--secondary-color);
            padding: 15px;
            border-radius: 5px;
        }
        
        .response-textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid var(--border-color);
            margin-bottom: 10px;
            resize: vertical;
            font-family: inherit;
        }
        
        .response-content {
            display: none;
            background-color: var(--secondary-color);
            padding: 15px;
            border-radius: 5px;
            margin-top: 10px;
            font-size: 0.85rem;
        }
        
        .response-date {
            display: block;
            margin-top: 5px;
            font-size: 0.75rem;
            color: var(--light-text);
            text-align: right;
        }
        
        .action-buttons {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }
        
        .status-select {
            padding: 5px;
            border-radius: 4px;
            border: 1px solid var(--border-color);
            font-size: 0.8rem;
            min-width: 120px;
        }
        
        .no-inquiries {
            text-align: center;
            padding: 2rem;
            color: var(--light-text);
            font-style: italic;
        }
        
        @media (max-width: 768px) {
            .inquiry-container {
                padding: 1rem;
            }
            
            .inquiry-table {
                display: block;
                overflow-x: auto;
            }
            
            .navbar {
                flex-direction: column;
                padding: 1rem;
            }
            
            .nav-links {
                margin-top: 1rem;
            }
            
            .nav-links li {
                margin-left: 1rem;
                margin-right: 1rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="CustomerSupportProfile.jsp">Dashboard</a></li>
            <li><a href="InquiryGetAllServlet"> Inquiries</a></li>
            <li><a href="LogoutServlet"> Logout</a></li>
        </ul>
    </nav>

    <div class="inquiry-container">
        <h2><i class="fas fa-inbox"></i> Customer Inquiries</h2>
        
        <% if (request.getParameter("statusUpdateSuccess") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Status updated successfully!
            </div>
        <% } %>
        <% if (request.getParameter("responseSuccess") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Response added successfully!
            </div>
        <% } %>
        <% if (request.getParameter("deleteSuccess") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Inquiry deleted successfully!
            </div>
        <% } %>
        <% if (request.getParameter("statusUpdateError") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> Error updating status. Please try again.
            </div>
        <% } %>
        <% if (request.getParameter("responseError") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> Error adding response. Please try again.
            </div>
        <% } %>
        <% if (request.getParameter("deleteError") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> Error deleting inquiry. Please try again.
            </div>
        <% } %>
        
        <c:choose>
            <c:when test="${not empty inquiries}">
                <table class="inquiry-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Subject</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Response</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="inquiry" items="${inquiries}">
                            <tr>
                                <td>${inquiry.id}</td>
                                <td>${inquiry.customerId}</td>
                                <td>${inquiry.subject}</td>
                                <td>
                                    <span class="status-badge status-${inquiry.status.toLowerCase().replace(' ', '-')}">
                                        ${inquiry.status}
                                    </span>
                                </td>
                                <td>${inquiry.createdAt}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty inquiry.response}">
                                            <button onclick="showResponse(${inquiry.id})" class="btn btn-view">
                                                <i class="fas fa-eye"></i> View Response
                                            </button>
                                            <div id="response-${inquiry.id}" class="response-content">
                                                ${inquiry.response}
                                                <span class="response-date">${inquiry.responseDate}</span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            No response yet
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                               <!-- In the Actions column, replace the existing forms with these links -->
                               <!-- In the Actions column -->
								<td>
								    <div class="action-buttons">
								        <a href="${pageContext.request.contextPath}/UpdateInquiryServlet?id=${inquiry.id}" class="btn btn-update">
								            <i class="fas fa-edit"></i> Edit
								        </a>
								        
								        <a href="${pageContext.request.contextPath}/RespondToInquiryServlet?id=${inquiry.id}" class="btn btn-respond">
								            <i class="fas fa-reply"></i> Respond
								        </a>
								        
								        <form action="${pageContext.request.contextPath}/DeleteInquirySupportServlet" method="post" style="display:inline;">
								            <input type="hidden" name="id" value="${inquiry.id}">
								            <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this inquiry?')">
								                <i class="fas fa-trash"></i> Delete
								            </button>
								        </form>
								    </div>
								</td>
                      </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-inquiries">
                    <i class="fas fa-inbox fa-2x" style="margin-bottom: 1rem;"></i>
                    <p>No inquiries found</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function showResponse(id) {
            var responseDiv = document.getElementById('response-' + id);
            if (responseDiv.style.display === 'none') {
                responseDiv.style.display = 'block';
            } else {
                responseDiv.style.display = 'none';
            }
        }
        
        function showResponseForm(id) {
            var form = document.getElementById('response-form-' + id);
            form.style.display = 'block';
            // Scroll to the form for better UX
            form.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
        
        function hideResponseForm(id) {
            var form = document.getElementById('response-form-' + id);
            form.style.display = 'none';
        }
    </script>
</body>
</html>