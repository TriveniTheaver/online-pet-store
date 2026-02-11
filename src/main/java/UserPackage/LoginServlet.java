/*package UserPackage;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Invalidate any existing session to prevent session fixation
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }
        response.sendRedirect("Login.jsp");
    }

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            response.sendRedirect("Login.jsp?message=Email and password are required");
            return;
        }
        //if valid
        try {
            List<UserModel> userList = UserDAO.loginValidate(email, password);

            if (userList != null && !userList.isEmpty()) {
                UserModel user = userList.get(0);
                
                // Create new session with security attributes
                HttpSession session = request.getSession(true);
                session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout
                
                // Set user attributes
                setUserSessionAttributes(session, user);
                
                // Security measures
                response.setHeader("Set-Cookie", 
                    "JSESSIONID=" + session.getId() + 
                    "; HttpOnly; SameSite=Strict; Path=/; Secure");
                
                // Handle post-login redirect
                handlePostLoginRedirect(session, user, response);
                
            } else {
                // Failed login attempt
                response.sendRedirect("Login.jsp?message=Invalid email or password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Login.jsp?message=Login error: " + e.getMessage());
        }
    }
    
    
    
    
    private void handlePostLoginRedirect(HttpSession session, UserModel user, 
                                       HttpServletResponse response) throws IOException {
        
    	// Default role-based redirect-polymorphic call
        String targetPage = user.determineRedirectPage();
        System.out.println("Redirecting to: " + targetPage);
        response.sendRedirect(targetPage);
        
        
        // Check for redirectAfterLogin
        String redirectAfterLogin = (String) session.getAttribute("redirectAfterLogin");
        if (redirectAfterLogin != null && !redirectAfterLogin.isEmpty()) {
            session.removeAttribute("redirectAfterLogin");
            response.sendRedirect(redirectAfterLogin);
            return;
        }
        
        
     // Check for pending order first-customer 
        if (session.getAttribute("pendingOrderData") != null) {
            session.removeAttribute("pendingOrderData");
            response.sendRedirect("ConfirmOrderServlet");
            return;
        }
        
    }
    
    private void setUserSessionAttributes(HttpSession session, UserModel user) {
        // Store user object
        session.setAttribute("user", user);
        
        // Store individual attributes for compatibility
        session.setAttribute("userId", user.getId());
        session.setAttribute("userEmail", user.getGmail());
        session.setAttribute("userRole", user.getRole().toLowerCase());
        session.setAttribute("userName", user.getName());
        session.setAttribute("customerId", user.getId());
        
        // Log successful login
        System.out.println("Login successful for user ID: " + user.getId());
        System.out.println("User role: " + user.getRole());
    }

       
}*/


package UserPackage;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Show login page
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) oldSession.invalidate();
        response.sendRedirect("Login.jsp");
    }

    
    // Handle login in one linear method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 1. Get and validate inputs
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
                response.sendRedirect("Login.jsp?message=Email and password are required");
                return;
            }

            // 2. Authenticate
            List<UserModel> userList = UserDAO.loginValidate(email, password);
            if (userList == null || userList.isEmpty()) {
                response.sendRedirect("Login.jsp?message=Invalid email or password");
                return;
            }

            // 3. Create session
            //Gets the first (one and only) user from the list
            
            UserModel user = userList.get(0);
            
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(30 * 60);
            //Stores all relevant user information in session attributes
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userEmail", user.getGmail());
            session.setAttribute("userRole", user.getRole().toLowerCase());
            session.setAttribute("userName", user.getName());
            session.setAttribute("customerId", user.getId());
            response.setHeader("Set-Cookie", "JSESSIONID=" + session.getId() + "; HttpOnly; SameSite=Strict; Path=/; Secure");

            
            
            
         // 4. Redirect
            //for customer If there was a pending order before login, redirects to order confirmation
            if (session.getAttribute("pendingOrderData") != null) {
                session.removeAttribute("pendingOrderData");
                response.sendRedirect("Payment.jsp");
            } 
            // polymorphism -> uses polymorphic determineRedirectPage() method to get role-specific landing page
            else {
                response.sendRedirect(user.determineRedirectPage());
            }
            
            
            
          //Catches any exceptions during the process  
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Login.jsp?message=Login error: " + e.getMessage());
        }
    }

   
}