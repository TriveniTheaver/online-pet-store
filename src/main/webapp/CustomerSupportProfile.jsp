<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="EstorePackage.InquiryDAO" %>
<%@ page import="UserPackage.SessionUtil" %>

<%
// Enhanced session validation
if (!SessionUtil.validateRole(request, response, "customersupport")) {
    return; // This will stop further execution after redirect
}

HttpSession sessionUser = request.getSession(false);
if (sessionUser == null) {
    response.sendRedirect("Login.jsp?message=Session expired");
    return;
}

// Get inquiry statistics
int totalInquiries = InquiryDAO.getTotalInquiriesCount();
int solvedInquiries = InquiryDAO.getSolvedInquiriesCount();
int openInquiries = InquiryDAO.getOpenInquiriesCount();


//Get context path for AJAX calls
String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Support Dashboard</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --warning: #f8961e;
            --info: #4895ef;
            --text: #2b2d42;
            --background: #f8f9fa;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--background);
            color: var(--text);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        
        .main-content {
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
            flex: 1;
        }
        
        .dashboard-header {
            text-align: center;
            margin-bottom: 3rem;
            position: relative;
        }
        
        .dashboard-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 1rem;
            position: relative;
            display: inline-block;
        }
        
        .dashboard-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: var(--accent);
            border-radius: 2px;
        }
        
        .dashboard-subtitle {
            color: var(--text);
            font-size: 1.1rem;
            max-width: 700px;
            margin: 0 auto;
        }
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 3rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            border: none;
        }
        
        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.12);
        }
        
        .stat-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
        }
        
        .stat-card.total:before {
            background: linear-gradient(90deg, var(--info), #4cc9f0);
        }
        
        .stat-card.solved:before {
            background: linear-gradient(90deg, var(--success), #4cc9f0);
        }
        
        .stat-card.open:before {
            background: linear-gradient(90deg, var(--warning), #f8961e);
        }
        
        .stat-content {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        
        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .stat-icon {
            font-size: 2.5rem;
            color: white;
            background: var(--primary);
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
        }
        
        .stat-card.total .stat-icon {
            background: linear-gradient(135deg, var(--info), #4cc9f0);
        }
        
        .stat-card.solved .stat-icon {
            background: linear-gradient(135deg, var(--success), #4cc9f0);
        }
        
        .stat-card.open .stat-icon {
            background: linear-gradient(135deg, var(--warning), #f8961e);
        }
        
        .stat-label {
            font-size: 1rem;
            color: var(--text);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
        }
        
        .stat-value {
            font-size: 3rem;
            font-weight: 700;
            margin: 0.5rem 0;
            line-height: 1;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .stat-card.total .stat-value {
            background: linear-gradient(135deg, var(--info), #4cc9f0);
            -webkit-background-clip: text;
        }
        
        .stat-card.solved .stat-value {
            background: linear-gradient(135deg, var(--success), #4cc9f0);
            -webkit-background-clip: text;
        }
        
        .stat-card.open .stat-value {
            background: linear-gradient(135deg, var(--warning), #f8961e);
            -webkit-background-clip: text;
        }
        
        .stat-description {
            font-size: 0.9rem;
            color: #6c757d;
            margin-top: auto;
            padding-top: 1rem;
            border-top: 1px solid #e9ecef;
        }
        
        .action-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
            text-align: center;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.12);
            border-color: var(--primary);
        }
        
        .action-icon {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
        }
        
        .action-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--text);
        }
        
        .action-description {
            color: #6c757d;
            margin-bottom: 1.5rem;
            font-size: 1rem;
        }
        
        .action-button {
            display: inline-block;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
        }
        
        .action-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(67, 97, 238, 0.3);
            color: white;
        }
        
       
        
        @media (max-width: 992px) {
            .stats-container {
                grid-template-columns: 1fr 1fr;
            }
        }
        
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                padding: 1rem;
            }
            
            .nav-links {
                margin-top: 1rem;
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .dashboard-title {
                font-size: 2rem;
            }
        }
        
        /* Animation */
        @keyframes float {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }
        
        
        
        .clickable-card {
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .clickable-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }
        
        .clickable-card:active {
            transform: translateY(0);
        }
        /* Modal styles for inquiry lists */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            overflow-y: auto;
        }
        
        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 2rem;
            border-radius: 10px;
            width: 80%;
            max-width: 900px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            animation: modalOpen 0.4s ease-out;
        }
        
      
        
        .inquiry-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        
        .inquiry-table th, .inquiry-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .inquiry-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }
        
        .inquiry-table tr:hover {
            background-color: #f8f9fa;
        }
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .status-open {
            background-color: #fff3bf;
            color: #e67700;
        }
        
        .status-resolved {
            background-color: #d3f9d8;
            color: #2b8a3e;
        }
        
        .action-link {
            color: #4361ee;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }
        
        .action-link:hover {
            color: #3f37c9;
            text-decoration: underline;
        }
        
        .clickable-card {
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .clickable-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="CustomerSupportProfile.jsp"><i class="fas fa-tachometer-alt"></i>Dashboard</a></li>
            <li><a href="InquiryGetAllServlet"><i class="fas fa-boxes"></i> Inquiries</a></li>
            <li><a href="about.jsp"> <i class="fas fa-info-circle"></i>About</a></li>
            <li><a href="blog.jsp"><i class="fas fa-blog"></i> Blog</a></li>
            <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </nav>

    <div class="main-content">
        <div class="dashboard-header">
            <h1 style="font-size: 24px; color: #fef3c7; text-shadow: 1px 1px 0 #000, 2px 2px 0 #000, 3px 3px 0 #000;">
                <center>Welcome to Customer Support Dashboard</center>
            </h1>
        </div>
        
        <br>
        <div class="stats-container">
            <div class="stat-card total floating clickable-card" 
                 onclick="showInquiries('all')" 
                 style="animation-delay: 0.2s;">
                <div class="stat-content">
                    <div class="stat-header">
                        <div>
                            <div class="stat-label">Total Inquiries</div>
                            <div class="stat-value"><%= totalInquiries %></div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-inbox"></i>
                        </div>
                    </div>
                  
                </div>
            </div>
            
            <div class="stat-card solved floating clickable-card" 
                 onclick="showInquiries('solved')" 
                 style="animation-delay: 0.4s;">
                <div class="stat-content">
                    <div class="stat-header">
                        <div>
                            <div class="stat-label">Solved Inquiries</div>
                            <div class="stat-value"><%= solvedInquiries %></div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                    </div>
                   
                </div>
            </div>
            
            <div class="stat-card open floating clickable-card" 
                 onclick="showInquiries('open')" 
                 style="animation-delay: 0.6s;">
                <div class="stat-content">
                    <div class="stat-header">
                        <div>
                            <div class="stat-label">Open Inquiries</div>
                            <div class="stat-value"><%= openInquiries %></div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                    </div>
                   
                </div>
            </div>
        </div>
        <div class="action-card">
            <div class="action-icon">
                <i class="fas fa-comments"></i>
            </div>
            <h3 class="action-title">Customer Inquiries</h3>
            <p class="action-description">Respond to customer questions and concerns about our products and services</p>
            <a href="InquiryGetAllServlet" class="action-button">
                <i class="fas fa-arrow-right"></i> Manage Inquiries
            </a>
        </div>
        
     </div>  

    <!-- Footer -->
     <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </footer>
</body>
</html>