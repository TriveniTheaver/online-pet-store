package EstorePackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProceedToOrderServlet")
public class ProceedToOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            // Redirect to login page if the user is not logged in
            response.sendRedirect("Login.jsp");
        } else {
            // Redirect to the order page
            response.sendRedirect("OrderConfirmation.jsp");
        }
    }
}
