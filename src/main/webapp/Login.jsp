<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | MyPetStore</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6C5CE7;
            --secondary: #A29BFE;
            --accent: #FD79A8;
            --dark: #2D3436;
            --light: #F7F9FC;
            --success: #00B894;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
           
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }
        
        /* Floating pet animation */
        .floating-pets {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
            overflow: hidden;
        }
        
        .pet {
            position: absolute;
            opacity: 0.6;
            animation: float 15s infinite linear;
            filter: drop-shadow(0 5px 15px rgba(0,0,0,0.3));
        }
        
        @keyframes float {
            0% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-50px) rotate(10deg); }
            100% { transform: translateY(0) rotate(0deg); }
        }
        
       
        
      
       
        
        /* Ultra-modern login container */
        .login-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        
        .login-container {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);
            border: 1px solid rgba(255,255,255,0.2);
            position: relative;
            overflow: hidden;
        }
        
        .login-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 15s linear infinite;
            z-index: -1;
        }
        
        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }
        
        .login-header h2 {
            font-size: 2.5rem;
            color: white;
            margin-bottom: 10px;
            font-weight: 700;
        	background: linear-gradient(to right, #4B2E1A, #5C3A21, #7B4A2E, #CD853F);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        
        .login-header p {
            color: rgba(255,255,255,0.8);
            font-size: 1rem;
        }
        
        /* Advanced form styling */
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: white;
            font-weight: 500;
            font-size: 0.9rem;
        }
        
        .input-wrapper {
            position: relative;
        }
        
        .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255,255,255,0.7);
            transition: all 0.3s;
        }
        
        .form-control {
            width: 100%;
            padding: 15px 15px 15px 45px;
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 10px;
            color: white;
            font-size: 1rem;
            transition: all 0.3s;
            backdrop-filter: blur(5px);
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(253, 121, 168, 0.3);
            background: rgba(255,255,255,0.15);
        }
        
        .form-control::placeholder {
            color: rgba(255,255,255,0.5);
        }
        
        .form-control:focus + i {
            color: var(--accent);
            transform: translateY(-50%) scale(1.2);
        }
        
        /* Submit button with gradient and animation */
        .submit-btn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
          	background: linear-gradient(to right, #4B2E1A, #5C3A21, #7B4A2E, #8B5A2B);
          	color: white;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
            margin-top: 10px;
            box-shadow: 0 10px 20px rgba(108, 92, 231, 0.3);
        }
        
        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(108, 92, 231, 0.4);
        }
        
        .submit-btn:active {
            transform: translateY(0);
        }
        
        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: 0.5s;
        }
        
        .submit-btn:hover::before {
            left: 100%;
        }
        
        /* Error message styling */
        .error-message {
            color: #FF6B6B;
            background: rgba(255, 107, 107, 0.1);
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 20px;
            border: 1px solid rgba(255, 107, 107, 0.3);
            animation: shake 0.5s;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
        
        /* Register link styling */
        .register-link {
            text-align: center;
            margin-top: 25px;
        }
        
        .register-link a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            position: relative;
            transition: all 0.3s;
        }
        
        .register-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--accent);
            transition: width 0.3s;
        }
        
        .register-link a:hover::after {
            width: 100%;
        }
        
        /* Social login options */
        .social-login {
            margin-top: 30px;
            text-align: center;
        }
        
        .social-login p {
            color: rgba(255,255,255,0.7);
            margin-bottom: 15px;
            position: relative;
        }
        
        .social-login p::before,
        .social-login p::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 30%;
            height: 1px;
            background: rgba(255,255,255,0.2);
        }
        
        .social-login p::before {
            left: 0;
        }
        
        .social-login p::after {
            right: 0;
        }
        
        .social-icons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        .social-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            transition: all 0.3s;
            border: 1px solid rgba(255,255,255,0.2);
        }
        
        .social-icon:hover {
            background: rgba(255,255,255,0.2);
            transform: translateY(-3px);
        }
        
        /* Footer styling */
        footer {
            background: rgba(0,0,0,0.2);
            backdrop-filter: blur(10px);
            padding: 20px;
            text-align: center;
            margin-top: auto;
        }
        
        .footer-content p {
            color: rgba(255,255,255,0.7);
            margin-bottom: 10px;
        }
        
        .social-icons-footer {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        .social-icons-footer a {
            color: white;
            font-size: 1.2rem;
            transition: all 0.3s;
        }
        
        .social-icons-footer a:hover {
            color: var(--accent);
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
   

    <!-- Modern navbar -->
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="Home.jsp">Home</a></li>
            <li><a href="Shop.jsp" class="cart"><i class="fas fa-shopping-cart"></i></a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Blog</a></li>
            <li><a href="#">Contact</a></li>
            
        </ul>
    </nav>
 
    <!-- Main login content -->
    <div class="login-wrapper">
        <div class="login-container">
            <div class="login-header">
                <h2>Welcome Back</h2>
                <p>Sign in to access your account</p>
            </div>
            
            <%-- to Display error message if present --%>
            <% String message = request.getParameter("message"); %>
            <% if (message != null && !message.isEmpty()) { %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> <%= message %>
                </div>
            <% } %>
            
            <form action="LoginServlet" method="POST">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrapper">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" class="form-control" placeholder="your@email.com" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
                    </div>
                </div>
                
                <button type="submit" class="submit-btn">
                    <span>Login</span>
                </button>
                
                <div class="register-link">
                    <p>New to MyPetStore? <a href="Register.jsp">Create an account</a></p>
                </div>
                
                <div class="social-login">
                    <p>or continue with</p>
                    <div class="social-icons">
                        <a href="#" class="social-icon"><i class="fab fa-google"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-apple"></i></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p>
            <div class="social-icons-footer">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </footer>

    
</body>
</html>