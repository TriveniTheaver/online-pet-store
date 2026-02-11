<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Pet Store</title>
    <link rel="stylesheet" href="css/styles.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
   
</head>
<body >

    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">🐈🐶 MyPetStore</div>
        <ul class="nav-links">
            <li><a href="#">Home</a></li>
            <li><a href="Shop.jsp" class="cart"><i class="fas fa-shopping-cart"></i></a></li>
           
            <li><a href="about.jsp">About</a></li>
            <li><a href="blog.jsp">Blog</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            
           <li><a href="Login.jsp" class="login-btn">Login</a></li>
        </ul>
    </nav>

    <!-- Hero Section -->
    <header class="hero">
        <div class="hero-content" style="margin-top: 170px;">
        <h1 style="color: #fff; text-shadow: 1px 1px 0 #000, 2px 2px 0 #000, 3px 3px 0 #000;">
  		<center>Welcome to MyPetStore</center>
		</h1>
            
            <p>Your one-stop shop for all pet needs</p>
            <a href="Shop.jsp" class="shop-btn">Shop Now</a>
        </div>
    </header>

    <!-- Featured Products -->
    <section class="products">
        <h2 style="color:white;">Featured Products / Best Selling Products</h2>
        <div class="product-container">
            <div class="product-card">
                <img src="https://source.unsplash.com/300x200/?dog,toy" alt="Dog Toy">
                <h3>Dog Chew Toy</h3>
                <p>$10.99</p>
                <button>Add to Cart</button>
            </div>
            <div class="product-card">
                <img src="https://source.unsplash.com/300x200/?cat,food" alt="Cat Food">
                <h3>Premium Cat Food</h3>
                <p>$15.99</p>
                <button>Add to Cart</button>
            </div>
            <div class="product-card">
                <img src="https://source.unsplash.com/300x200/?puppy,bed" alt="Pet Bed">
                <h3>Cozy Pet Bed</h3>
                <p>$25.99</p>
                <button>Add to Cart</button>
            </div>
             <div class="product-card">
                <img src="https://source.unsplash.com/300x200/?puppy,bed" alt="Pet Bed">
                <h3>Cozy Pet Litter</h3>
                <p>$25.99</p>
                <button>Add to Cart</button>
            </div>
          
        </div>
        
    </section>

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
