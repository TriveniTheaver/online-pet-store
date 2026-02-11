package EstorePackage;



import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateInquiryStatusServlet")
public class UpdateInquiryStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int inquiryId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        
        boolean isSuccess = InquiryDAO.updateInquiryStatus(inquiryId, status);
        
        if (isSuccess) {
            response.sendRedirect("InquiryGetAllServlet?statusUpdateSuccess=true");
        } else {
            response.sendRedirect("InquiryGetAllServlet?statusUpdateError=true");
        }
    }
}
