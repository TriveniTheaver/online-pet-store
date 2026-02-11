package EstorePackage;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/OrderDetailsServlet")
public class OrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int customerId = (Integer) session.getAttribute("userId");
        
        try {
            OrderModel order = OrderDAO.getOrderById(orderId);
            
            // Verify the order belongs to the customer
            if (order == null || order.getCustomerId() != customerId) {
                response.sendRedirect("OrderHistoryServlet?error=unauthorized");
                return;
            }
            
            request.setAttribute("order", order);
            RequestDispatcher dispatcher = request.getRequestDispatcher("OrderDetails.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("OrderHistoryServlet?error=details");
        }
    }
}