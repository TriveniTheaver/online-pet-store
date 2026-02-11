<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About MyPetStore</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .about-container {
            background: rgba(255, 255, 255, 0.7);
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 55%;
            margin: 50px auto;
            color: black;
        }
        .about-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .about-section {
            margin-bottom: 30px;
        }
        .team-member {
            display: inline-block;
            width: 30%;
            margin: 1%;
            text-align: center;
            vertical-align: top;
        }
        .team-member img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 15px;
        }
        .values-list {
            list-style-type: none;
            padding: 0;
        }
        .values-list li {
            background: #f8f9fa;
            margin-bottom: 10px;
            padding: 15px;
            border-radius: 5px;
        }
		        
		.team-section {
		    display: flex;
		    flex-wrap: wrap;
		    justify-content: center;
		    gap: 30px;
		    margin: 40px 0;
		}
		
		.team-member {
		    width: 280px;
		    text-align: center;
		    padding: 25px;
		    background: rgba(255,255,255,0.9);
		    border-radius: 15px;
		    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
		    transition: transform 0.3s;
		}
		
		.team-member:hover {
		    transform: translateY(-10px);
		}
		
		.ai-portrait {
		    width: 150px;
		    height: 150px;
		    border-radius: 50%;
		    object-fit: cover;
		    border: 5px solid #f8e1d4;
		    margin-bottom: 15px;
		}
		
		.position {
		    color: #b08a6c;
		    font-weight: 600;
		    margin: 5px 0;
		}
		
		.bio {
		    font-size: 14px;
		    line-height: 1.5;
		    margin: 10px 0;
		}
		
		.fun-fact {
		    font-size: 13px;
		    color: #7f8c8d;
		    font-style: italic;
		    margin-top: 10px;
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

    <div class="about-container">
        <div class="about-header">
            <h1>About MyPetStore</h1>
            <p class="subtitle">Your trusted partner in pet care since 2015</p>
        </div>

        <div class="about-section">
            <h2>Our Story</h2>
            <p>Founded in 2015 by animal lovers Sarah Johnson and Michael Chen, MyPetStore began as a small neighborhood pet shop in San Francisco. What started as a passion project quickly grew into one of the most trusted names in pet care, thanks to our commitment to quality products and exceptional customer service.</p>
            <p>Today, we serve thousands of happy pets and their owners across California, with plans to expand nationwide. We're proud to be a certified B Corporation, meeting the highest standards of social and environmental performance.</p>
        </div>

        <div class="about-section">
            <h2>Our Mission</h2>
            <p>At MyPetStore, we believe pets are family. Our mission is to provide premium products and expert advice to help pet parents give their companions the happy, healthy lives they deserve.</p>
            
            <ul class="values-list">
                <li><strong>Quality First:</strong> We rigorously test all products before they reach your pet</li>
                <li><strong>Expert Advice:</strong> Our staff includes certified pet nutritionists and trainers</li>
                <li><strong>Sustainable Practices:</strong> 80% of our products are eco-friendly or sustainably sourced</li>
                <li><strong>Community Focus:</strong> We donate 5% of profits to local animal shelters</li>
            </ul>
        </div>

        <div class="about-section">
            <h2>Meet Our Team</h2>
            
           
    <div class="team-member">
        <img src="images/o.jpg" alt="Oshani" class="ai-portrait">
        <h3>Oshani De Run</h3>
        <p class="position">Co-Founder & CEO</p>
        <p class="bio">DVM, MBA with 15 years in veterinary medicine. Former director of Animal Welfare International.</p>
        <p class="fun-fact">🐕 Rescued over 200 stray dogs in Southeast Asia</p>
    </div>
    
    <div class="team-member">
        <img src="images/d.webp" alt="Dilukshini" class="ai-portrait">
        <h3>Dilukshini Sander</h3>
        <p class="position">Co-Founder & COO</p>
        <p class="bio">Zoology PhD with 12 years at San Diego Zoo. Specializes in exotic animal behavior.</p>
        <p class="fun-fact">🦜 Speaks 4 languages and can communicate with parrots</p>
    </div>
    
    <div class="team-member">
        <img src="images/j.webp" alt="Jagarthana" class="ai-portrait">
        <h3>Jagarthana Shanthikumar</h3>
        <p class="position">Chief Product Officer</p>
        <p class="bio">Double PhD in Animal Nutrition and Food Science from Cornell. Developed 50+ pet formulas.</p>
        <p class="fun-fact">🥕 Created the world's first vegan dog food approved by vets</p>
    </div>
    
    <div class="team-member">
        <img src="images/t.webp" alt="Triveni" class="ai-portrait">
        <h3>Triveni Theaver</h3>
        <p class="position">Chief Technology Officer</p>
        <p class="bio">MIT graduate who built AI systems for animal health monitoring. Holds 12 pet tech patents.</p>
        <p class="fun-fact">🤖 Designed a robot that plays fetch with anxious dogs</p>
    </div>

        <div class="about-section">
            <h2>Our Awards</h2>
            <p>🏆 <strong>2023 Best Pet Store</strong> - Bay Area Pet Lovers Association</p>
            <p>🏆 <strong>2022 Eco-Friendly Business Award</strong> - California Green Business Network</p>
            <p>🏆 <strong>2021 Customer Service Excellence</strong> - Retail Professionals of America</p>
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