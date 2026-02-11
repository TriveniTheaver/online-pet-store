<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Inquiries</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .inquiry-container {
            background: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 10px;
            max-width: 1000px;
            margin: 30px auto;
        }
        .inquiry-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .inquiry-table th, .inquiry-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .inquiry-table th {
            background-color: #b08a6c;
            color: white;
        }
        .status-open {
            color: #e74c3c;
            font-weight: bold;
        }
        .status-resolved {
            color: #2ecc71;
            font-weight: bold;
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-edit {
            background-color: #3498db;
            color: white;
        }
        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }
        .btn-new {
            background-color: #b08a6c;
            color: white;
            padding: 10px 15px;
            margin-bottom: 20px;
        }
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
        .alert-error {
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

    <div class="inquiry-container">
        <h2>My Inquiries</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">Inquiry submitted successfully!</div>
        <% } %>
        <% if (request.getParameter("updateSuccess") != null) { %>
            <div class="alert alert-success">Inquiry updated successfully!</div>
        <% } %>
        <% if (request.getParameter("deleteSuccess") != null) { %>
            <div class="alert alert-success">Inquiry deleted successfully!</div>
        <% } %>
        <% if (request.getParameter("updateError") != null) { %>
            <div class="alert alert-error">Error updating inquiry. Please try again.</div>
        <% } %>
        <% if (request.getParameter("deleteError") != null) { %>
            <div class="alert alert-error">Error deleting inquiry. Please try again.</div>
        <% } %>
        
        <a href="CreateInquiry.jsp" class="btn btn-new">Create New Inquiry</a>
        
        <table class="inquiry-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Subject</th>
            <th>Status</th>
            <th>Date</th>
            <th>Response</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${empty inquiries}">
                <tr>
                    <td colspan="6">No inquiries found</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="inquiry" items="${inquiries}">
                    <tr>
                        <td>${inquiry.id}</td>
                        <td>${inquiry.subject}</td>
                        <td class="status-${inquiry.status.toLowerCase()}">${inquiry.status}</td>
                        <td>${inquiry.createdAt}</td>
                        <td>
                            <c:if test="${not empty inquiry.response}">
                                <button onclick="showResponse(${inquiry.id})">View Response</button>
                                <div id="response-${inquiry.id}" style="display:none;">
                                    ${inquiry.response}
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <a href="EditInquiry.jsp?id=${inquiry.id}&subject=${inquiry.subject}&message=${inquiry.message}" 
                               class="btn btn-edit">Edit</a>
                            <form action="DeleteInquiryServlet" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${inquiry.id}">
                                <button type="submit" class="btn btn-delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>
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
    </script>
</body>
</html>