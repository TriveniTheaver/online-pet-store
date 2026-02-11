<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="UserPackage.SessionUtil" %>
<% 
if (!SessionUtil.validateRole(request, response, "productmanager")) {
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Product</title>
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
    
    input[type="text"] {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid var(--border-color);
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
        transition: all 0.3s ease;
    }
    
    input[type="text"]:focus {
        border-color: var(--primary-color);
        outline: none;
        box-shadow: 0 0 0 3px rgba(52,152,219,0.2);
    }
    
    input[type="text"][readonly] {
        background-color: #f9f9f9;
        color: #777;
        cursor: not-allowed;
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
</style>
</head>
<body>
<div class="container">
    <div class="form-header">
        <h1>Edit Product</h1>
        <a href="DisplayProductDetails.jsp" class="back-link">← Back to Products</a>
    </div>
    
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        String quantity = request.getParameter("quantity");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
    %>
    
    <form action="ProductUpdateServlet" method="post">
        <table class="form-table">
            <tr>
                <td>Product ID:</td>
                <td><input type="text" name="id" value="<%=id%>" readonly></td>
            </tr>
            <tr>
                <td class="required">Name:</td>
                <td><input type="text" name="name" value="<%=name%>" required></td>
            </tr>
            <tr>
                <td class="required">Price:</td>
                <td><input type="text" name="price" value="<%=price%>" required></td>
            </tr>
            <tr>
                <td class="required">Category:</td>
                <td><input type="text" name="category" value="<%=category%>" required></td>
            </tr>
            <tr>
                <td class="required">Quantity:</td>
                <td><input type="text" name="quantity" value="<%=quantity%>" required></td>
            </tr>
            <tr>
                <td class="required">Description:</td>
                <td><input type="text" name="description" value="<%=description%>" required></td>
            </tr>    
            <tr>
                <td>Image URL:</td>
                <td><input type="text" name="imageUrl" value="<%=imageUrl != null ? imageUrl : ""%>"></td>
            </tr>
        </table>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Update Product</button>
        </div>
    </form>
</div>
</body>
</html>