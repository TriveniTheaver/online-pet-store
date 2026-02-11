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

@WebServlet("/CustomerInquiryServlet")
public class CustomerInquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || (session.getAttribute("userId") == null && session.getAttribute("userEmail") == null)) {
            response.sendRedirect("Login.jsp");
            return;
        }

        try {
            Integer customerId = (Integer) session.getAttribute("userId");
            String userEmail = (String) session.getAttribute("userEmail");
            
            System.out.println("CustomerInquiryServlet - customerId: " + customerId);
            System.out.println("CustomerInquiryServlet - userEmail: " + userEmail);
            
            List<InquiryModel> inquiries;
            
            if (customerId != null) {
                inquiries = InquiryDAO.getInquiriesByCustomerId(customerId);
            } else if (userEmail != null) {
                inquiries = InquiryDAO.getInquiriesByCustomerEmail(userEmail);
            } else {
                response.sendRedirect("Login.jsp");
                return;
            }
            
            System.out.println("Retrieved inquiries count: " + inquiries.size());
            
            request.setAttribute("inquiries", inquiries);
            RequestDispatcher dispatcher = request.getRequestDispatcher("CustomerInquiries.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CustomerProfile.jsp?error=fetch");
        }
    }
}