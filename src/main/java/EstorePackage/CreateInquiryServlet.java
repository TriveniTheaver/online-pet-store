package EstorePackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CreateInquiryServlet")
public class CreateInquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || (session.getAttribute("userId") == null && session.getAttribute("userEmail") == null)) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Get form data
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        // Validate inputs
        if (subject == null || subject.trim().isEmpty() || 
            message == null || message.trim().isEmpty()) {
            response.sendRedirect("CreateInquiry.jsp?error=empty");
            return;
        }

        try {
            Integer customerId = (Integer) session.getAttribute("userId");
            String userEmail = (String) session.getAttribute("userEmail");
            
            // If userId is not available but email is, get customerId from email
            if (customerId == null && userEmail != null) {
                customerId = InquiryDAO.getCustomerIdByEmail(userEmail);
                if (customerId == null) {
                    response.sendRedirect("Login.jsp");
                    return;
                }
            }

            // Create the inquiry
            boolean isSuccess = InquiryDAO.createInquiry(customerId, subject, message);
            
            if (isSuccess) {
                response.sendRedirect("CustomerInquiryServlet?success=true");
            } else {
                response.sendRedirect("CreateInquiry.jsp?error=create");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CreateInquiries.jsp?error=exception");
        }
    }
}