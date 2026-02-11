<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pet Care Blog | MyPetStore</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .blog-container {
            background: rgba(255, 255, 255, 0.7);
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 55%;
            margin: 50px auto;
            color: black;
        }
        .blog-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .blog-post {
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 1px solid #eee;
        }
        .blog-post:last-child {
            border-bottom: none;
        }
        .post-title {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .post-meta {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .post-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .read-more {
            display: inline-block;
            background-color: #b08a6c;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 15px;
        }
        .read-more:hover {
            background-color: #9a755a;
        }
        .categories {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .categories h3 {
            margin-top: 0;
        }
        .category-tag {
            display: inline-block;
            background: #e0e0e0;
            padding: 5px 10px;
            border-radius: 15px;
            margin: 5px;
            font-size: 14px;
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

    <div class="blog-container">
        <div class="blog-header">
            <h1>Pet Care Blog</h1>
            <p>Expert advice, tips, and stories for pet lovers</p>
        </div>

        <div class="categories">
            <h3>Categories</h3>
            <span class="category-tag">Dog Care</span>
            <span class="category-tag">Cat Nutrition</span>
            <span class="category-tag">Training Tips</span>
            <span class="category-tag">Pet Health</span>
            <span class="category-tag">Product Reviews</span>
        </div>

        <div class="blog-post">
            <h2 class="post-title">10 Essential Tips for First-Time Dog Owners</h2>
            <div class="post-meta">Posted on May 15, 2023 by Dr. Emily Rodriguez | 8 min read</div>
            <img src="https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80" alt="Happy dog" class="post-image">
            <p>Bringing home a new dog is exciting but can be overwhelming. Our veterinary expert shares her top tips for first-time dog parents, from choosing the right food to establishing a training routine...</p>
            <a href="#" class="read-more">Read More</a>
        </div>

        <div class="blog-post">
            <h2 class="post-title">The Ultimate Guide to Cat Nutrition: Wet vs. Dry Food</h2>
            <div class="post-meta">Posted on April 28, 2023 by Priya Patel | 6 min read</div>
            <img src="https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba" alt="Cat eating" class="post-image">
            <p>What's better for your feline friend - canned food or kibble? We break down the pros and cons of each option, including dental health considerations, hydration needs, and budget factors...</p>
            <a href="#" class="read-more">Read More</a>
        </div>

        <div class="blog-post">
            <h2 class="post-title">Eco-Friendly Pet Products That Actually Work</h2>
            <div class="post-meta">Posted on April 10, 2023 by Michael Chen | 5 min read</div>
            <img src="https://images.unsplash.com/photo-1588943211346-0908a1fb0b01" alt="Eco pet products" class="post-image">
            <p>Going green with your pet care routine? We tested 25 sustainable pet products to bring you our top picks for biodegradable waste bags, organic toys, and non-toxic grooming supplies...</p>
            <a href="#" class="read-more">Read More</a>
        </div>

        <div class="blog-post">
            <h2 class="post-title">How to Keep Your Pet Calm During Fireworks</h2>
            <div class="post-meta">Posted on March 22, 2023 by Sarah Johnson | 7 min read</div>
            <img src="https://images.unsplash.com/photo-1530281700549-e82e7bf110d6" alt="Scared dog" class="post-image">
            <p>With summer celebrations coming up, many pets will struggle with noise anxiety. Learn proven techniques to help your pet stay calm, from behavior modification to safe calming supplements...</p>
            <a href="#" class="read-more">Read More</a>
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