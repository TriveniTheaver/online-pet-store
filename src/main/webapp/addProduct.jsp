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
<title>Add Product Form</title>
<link rel="stylesheet" href="css/styles.css">
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
        color: #333;
    }
    
    .container {
        width: 700px;
        margin: 0 auto;
        background: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    h2 {
        color: #2c3e50;
        text-align: center;
        margin-bottom: 25px;
        border-bottom: 1px solid #eee;
        padding-bottom: 10px;
    }
    
    .form-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .form-table tr {
        border-bottom: 1px solid #eee;
    }
    
    .form-table td {
        padding: 12px 5px;
    }
    
    .form-table td:first-child {
        font-weight: 500;
        width: 30%;
    }
    
    input[type="text"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
    }
    
    input[type="text"]:focus {
        border-color: #3498db;
        outline: none;
        box-shadow: 0 0 5px rgba(52,152,219,0.3);
    }
    
    input[type="submit"] {
        background-color: #3498db;
        color: white;
        border: none;
        padding: 12px 20px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
        width: 100%;
        max-width: 200px;
        margin-top: 10px;
    }
    
    input[type="submit"]:hover {
        background-color: #2980b9;
    }
    
    .submit-cell {
        text-align: center;
        padding-top: 20px !important;
    }
    
    .required:after {
        content: " *";
        color: #e74c3c;
    }
    .form-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    select[name="category"] {
        padding: 5px;
        font-size: 14px;
    }

    td.required {
        font-weight: bold;
    }

    
</style>
</head>
<body>
<div class="container">
    
    <div class="form-header">
        <h2>Enter Product Details</h2>
       <a href="DisplayProductDetails.jsp" class="back-link">← Back to Products</a>
    </div>
    
    
    <%-- add product form --%>
    <form action="ProductInsertServlet" method="post">
        <table class="form-table">
            <tr>
                <td class="required">Name:</td>
                <td><input type="text" name="name" required></td>
            </tr>
            <tr>
                <td class="required">Price:</td>
                <td><input type="text" name="price" required></td>
            </tr>
            <tr>
			    <td class="required">Category:</td>
			    <td>
			        <select name="category" required>
			            <option value="">-- Select Category --</option>
			            <option value="dog">dog</option>
			            <option value="cat">cat</option>
			            <option value="fish">fish</option>
			            <option value="bird">bird</option>
			        </select>
			    </td>
			</tr>
            
            <tr>
                <td class="required">Quantity:</td>
                <td><input type="text" name="quantity" required></td>
            </tr>
            <tr>
                <td class="required">Description:</td>
                <td><input type="text" name="description" required></td>
            </tr>    
            <tr>
                <td>Image URL:</td>
                <td><input type="text" name="imageUrl"></td>
            </tr>
            <tr>
                <td colspan="2" class="submit-cell">
                
                    <input type="submit" value="Add Product">
                     
                </td>
            </tr>
        </table>
    </form>
    
    
</div>
</body>
</html>