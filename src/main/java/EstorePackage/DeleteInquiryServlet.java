package EstorePackage;



import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteInquiryServlet")
public class DeleteInquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        int customerId = (Integer) session.getAttribute("userId");
        int inquiryId = Integer.parseInt(request.getParameter("id"));
        
        boolean isSuccess = InquiryDAO.deleteInquiry(inquiryId, customerId);
        
        if (isSuccess) {
            response.sendRedirect("CustomerInquiryServlet?deleteSuccess=true");
        } else {
            response.sendRedirect("CustomerInquiryServlet?deleteError=true");
        }
    }
}
