/*package EstorePackage;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Ensure the session is valid and the user is logged in as a customer
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null || !"customer".equalsIgnoreCase(userRole)) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect("Login.jsp?message=Please login as customer to complete your order");
            return;
        }

        // ✅ Get customerId from session
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            response.sendRedirect("Login.jsp?message=Session expired. Please login again.");
            return;
        }

        List<CartModel> cartList = (List<CartModel>) session.getAttribute("cart-list");
        Double grandTotal = (Double) session.getAttribute("grandTotal");

        if (cartList == null || cartList.isEmpty() || grandTotal == null) {
            response.sendRedirect("Cart.jsp?error=Your cart is empty");
            return;
        }
        
     

        // ✅ Now pass customerId (int) to createOrder
        boolean isOrderCreated = OrderController.createOrder(customerId, cartList, grandTotal);

        if (isOrderCreated) {
            session.removeAttribute("cart-list");
            session.removeAttribute("grandTotal");

            session.setAttribute("orderSuccess", true);
            session.setAttribute("orderAmount", grandTotal);
            session.setAttribute("orderItems", cartList);

            response.sendRedirect("OrderConfirmation.jsp");
        } else {
            response.sendRedirect("Cart.jsp?error=Order failed. Please try again.");
        }
    }
}*/
package EstorePackage;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle GET requests (after login redirect)
        HttpSession session = request.getSession(false);
        
        // Check if we have a pending order attempt
        if (session != null && session.getAttribute("pendingOrderData") != null) {
            // Restore the order context
            request.setAttribute("restoringOrder", true);
            doPost(request, response);
        } else {
            // No pending order, redirect to cart
            response.sendRedirect("Cart.jsp?message=Please add items to your cart first");
        }
    }

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check if this is a restored order attempt after login
        boolean isRestoredOrder = request.getAttribute("restoringOrder") != null;
        
        // Session validation
        if (!validateSession(session, request, response, isRestoredOrder)) {
            return;
        }

        // Get order data from session
        List<CartModel> cartList = (List<CartModel>) session.getAttribute("cart-list");
        Double grandTotal = (Double) session.getAttribute("grandTotal");
        Integer customerId = (Integer) session.getAttribute("customerId");

        // Validate order data
        if (!validateOrderData(cartList, grandTotal, customerId, response, isRestoredOrder)) {
            return;
        }

        // Process the order
        processOrder(customerId, cartList, grandTotal, session, response);
    }

    private boolean validateSession(HttpSession session, HttpServletRequest request, 
                                  HttpServletResponse response, boolean isRestoredOrder) 
            throws IOException {
        // Check if user is logged in as customer
        String userRole = (String) session.getAttribute("userRole");
        
        if (userRole == null || !"customer".equalsIgnoreCase(userRole)) {
            if (!isRestoredOrder) {
                // Store current order data in session
                session.setAttribute("pendingOrderData", true);
                session.setAttribute("redirectAfterLogin", request.getRequestURI());
            }
            response.sendRedirect("Login.jsp?message=Please login as customer to complete your order");
            return false;
        }
        
        // Check session timeout
        if (session.getAttribute("customerId") == null) {
            response.sendRedirect("Login.jsp?message=Session expired. Please login again.");
            return false;
        }
        
        return true;
    }

    private boolean validateOrderData(List<CartModel> cartList, Double grandTotal, 
                                    Integer customerId, HttpServletResponse response,
                                    boolean isRestoredOrder) throws IOException {
        if (cartList == null || cartList.isEmpty() || grandTotal == null) {
            response.sendRedirect("Cart.jsp?error=" + 
                (isRestoredOrder ? "Your cart data was lost during login" : "Your cart is empty"));
            return false;
        }
        
        if (customerId == null) {
            response.sendRedirect("Login.jsp?message=Session expired. Please login again.");
            return false;
        }
        
        return true;
    }

    private void processOrder(Integer customerId, List<CartModel> cartList, 
                            Double grandTotal, HttpSession session,
                            HttpServletResponse response) throws IOException {
        try {
            // Create the order
            boolean isOrderCreated = OrderDAO.createOrder(customerId, cartList, grandTotal);

            if (isOrderCreated) {
                // Clear session data
                session.removeAttribute("cart-list");
                session.removeAttribute("grandTotal");
                session.removeAttribute("pendingOrderData");

                // Set confirmation data
                session.setAttribute("orderSuccess", true);
                session.setAttribute("orderAmount", grandTotal);
                session.setAttribute("orderItems", cartList);

                // Redirect to confirmation page
                response.sendRedirect("OrderConfirmation.jsp");
            } else {
                response.sendRedirect("Cart.jsp?error=Order failed. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Cart.jsp?error=Order processing error: " + e.getMessage());
        }
    }
}
