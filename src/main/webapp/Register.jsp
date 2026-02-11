<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - My Pet Store</title>
    <link rel="stylesheet" href="css/styles.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    
    <style>
        /* Registration Modal Styling */
        .register-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.6);
        }

        .register-box {
            display: flex;
            background: white;
            padding: 20px;
            border-radius: 10px;
            width: 60%;
            max-width: 900px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
        }

        .register-image {
            flex: 0.5;
           /* background: url('images/hi.webp') no-repeat center center;*/
            background-size: cover;
            border-radius: 10px 0 0 10px;
        }

        .register-form {
            flex: 1.5;
            padding: 20px;
            text-align: center;
        }

        .register-form h2 {
            margin-bottom: 10px;
        }

        .register-form input {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .register-form input[type="submit"] {
            background-color:#815f4d;
            color: white;
            border: none;
            cursor: pointer;
            padding: 10px;
            font-size: 16px;
        }

        .register-form input[type="submit"]:hover {
            background-color: #5e3f32;
        }

        .register-form p {
            margin-top: 10px;
        }

        .register-form a {
            color: #007BFF;
            text-decoration: none;
        }

        .register-form a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<!-- Registration Modal -->
<div class="register-container">
    <div class="register-box">
        <!-- Left Side Image -->
        <div class="register-image">
        	 <img src="images/hi.webp" alt="Nice to have you">
        </div>

        <!-- Right Side Form -->
        <div class="register-form">
            <h2>Nice to have you!</h2>
            <p>Create an account to enjoy all our features.</p>
            <form action="UserInsertServlet" method="post">
                <input type="text" name="name" placeholder="Full Name" required>
                <input type="email" name="gmail" placeholder="Email" required>
                <input type="password" name="password" placeholder="Password" required>
                <input type="text" name="phone" placeholder="Phone Number" required>
                <input type="text" name="role" placeholder="Role" required>
                <input type="submit" value="Register">
            </form>
            <p>Already have an account? <a href="Login.jsp">Login</a></p>
        </div>
    </div>
</div>

</body>
</html>
