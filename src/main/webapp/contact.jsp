<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us | MyPetStore</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .contact-hero {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5));
            background-size: cover;
            background-position: center;
            height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            margin-bottom: 50px;
        }
        
        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }
        
        .contact-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            text-align: center;
        }
        
        .contact-card:hover {
            transform: translateY(-10px);
        }
        
        .contact-icon {
            font-size: 40px;
            color: #b08a6c;
            margin-bottom: 20px;
        }
        
        .contact-form {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 50px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-control {
            width: 100%;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #b08a6c;
            box-shadow: 0 0 0 3px rgba(176, 138, 108, 0.2);
            outline: none;
        }
        
        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }
        
        .submit-btn {
            background: #b08a6c;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
        }
        
        .submit-btn:hover {
            background: #9a755a;
            transform: translateY(-2px);
        }
        
        .pet-emoji {
            font-size: 24px;
            margin-right: 10px;
            vertical-align: middle;
        }
        
        .map-container {
            height: 400px;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 50px;
        }
        
        .social-links {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        
        .social-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            background: #f5f5f5;
            border-radius: 50%;
            color: #b08a6c;
            font-size: 20px;
            transition: all 0.3s;
        }
        
        .social-link:hover {
            background: #b08a6c;
            color: white;
            transform: scale(1.1);
        }
        
        .hours-list {
            list-style: none;
            padding: 0;
        }
        
        .hours-list li {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        
        .hours-list li:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">MyPetStore</div>
        <ul class="nav-links">
            <li><a href="Home.jsp">Home</a></li>
            
            <li><a href="about.jsp">About</a></li>
            <li><a href="blog.jsp">Blog</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>
    </nav>

    <div class="contact-hero">
        <div>
            <h1>We'd Love to Hear From You <i class="fas fa-paw"></i></h1>
            <p>Whether you have questions about products, adoption, or just want to say hello!</p>
        </div>
    </div>

    <div class="contact-container">
        <div class="contact-grid">
            <div class="contact-card">
                <div class="contact-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <h3>Visit Us</h3>
                <p>123 Pet Paradise Lane<br>Kandy,20000</p>
                <p><span class="pet-emoji">🐾</span> Free parking available</p>
                <p><span class="pet-emoji">🐶</span> Pet-friendly store</p>
            </div>
            
            <div class="contact-card">
                <div class="contact-icon">
                    <i class="fas fa-phone-alt"></i>
                </div>
                <h3>Call Us</h3>
                <p>General Inquiries: <br><strong>(415) 555-PETS</strong></p>
                <p>Adoption Services: <br><strong>(415) 555-LOVE</strong></p>
                <p><span class="pet-emoji">⏰</span> 24/7 Emergency Vet Line</p>
            </div>
            
            <div class="contact-card">
                <div class="contact-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <h3>Store Hours</h3>
                <ul class="hours-list">
                    <li><span>Monday-Friday</span> <span>9am - 8pm</span></li>
                    <li><span>Saturday</span> <span>10am - 7pm</span></li>
                    <li><span>Sunday</span> <span>11am - 5pm</span></li>
                    <li><span>Holidays</span> <span>Special Hours</span></li>
                </ul>
            </div>
        </div>

        <div class="contact-form">
            <h2><i class="fas fa-envelope pet-emoji"></i> Send Us a Message</h2>
            <form action="ContactServlet" method="post">
                <div class="form-group">
                    <input type="text" class="form-control" name="name" placeholder="Your Name" required>
                </div>
                <div class="form-group">
                    <input type="email" class="form-control" name="email" placeholder="Your Email" required>
                </div>
                <div class="form-group">
                    <select class="form-control" name="subject" required>
                        <option value="" disabled selected>Select Subject</option>
                        <option value="product">Product Inquiry</option>
                        <option value="adoption">Adoption Question</option>
                        <option value="appointment">Grooming Appointment</option>
                        <option value="feedback">Feedback/Suggestion</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <textarea class="form-control" name="message" placeholder="Your Message" required></textarea>
                </div>
                <button type="submit" class="submit-btn">Send Message <i class="fas fa-paper-plane"></i></button>
            </form>
            
            <div class="social-links">
                <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
                <a href="#" class="social-link"><i class="fab fa-tiktok"></i></a>
            </div>
        </div>

        <div class="map-container">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3153.434570535889!2d-122.4194155846823!3d37.77492997975946!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x80859a6d00690021%3A0x4a501367f076adff!2sSan%20Francisco%2C%20CA%2C%20USA!5e0!3m2!1sen!2slk!4v1629999999999!5m2!1sen!2slk" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <p>&copy; 2025 My Pet Store | All Rights Reserved</p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </footer>
</body>
</html>