package EstorePackage;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int customerId = (Integer) session.getAttribute("userId");
        
        try {
            List<OrderModel> orders = OrderDAO.getOrdersByCustomerId(customerId);
            request.setAttribute("orders", orders);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("OrderHistory.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CustomerProfile.jsp?error=order_history");
        }
    }
}