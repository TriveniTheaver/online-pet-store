package UserPackage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessionUtil {
    // Basic session validation
    public static boolean validateSession(HttpServletRequest request, HttpServletResponse response) 
            throws java.io.IOException {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("userId") != null;
    }

    // Role-specific validation
    public static boolean validateRole(HttpServletRequest request, HttpServletResponse response, String requiredRole) 
            throws java.io.IOException {
        HttpSession session = request.getSession(false);
        
        // Check if session exists
        if (!validateSession(request, response)) {
            response.sendRedirect("Login.jsp?message=Please login first");
            return false;
        }
        
        // Check role
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null || !userRole.equalsIgnoreCase(requiredRole)) {
            response.sendRedirect("Home.jsp?message=Unauthorized access");
            return false;
        }
        return true;
    }
}