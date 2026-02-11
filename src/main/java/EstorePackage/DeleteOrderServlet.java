package EstorePackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteOrderServlet")
public class DeleteOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int customerId = (Integer) session.getAttribute("userId");
        
        try {
            // Verify the order belongs to the customer before deleting
            OrderModel order = OrderDAO.getOrderById(orderId);
            if (order == null || order.getCustomerId() != customerId) {
                response.sendRedirect("OrderHistoryServlet?error=unauthorized");
                return;
            }
            
            // Delete the order
            boolean success = OrderDAO.deleteOrder(orderId);
            
            if (success) {
                response.sendRedirect("OrderHistoryServlet?success=delete");
            } else {
                response.sendRedirect("OrderHistoryServlet?error=delete_failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("OrderHistoryServlet?error=exception");
        }
    }
}