package EstorePackage;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteInquirySupportServlet")
public class DeleteInquirySupportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int inquiryId = Integer.parseInt(request.getParameter("id"));
        
        boolean isSuccess = InquiryDAO.deleteInquiry(inquiryId);
        
        if (isSuccess) {
            response.sendRedirect("InquiryGetAllServlet?deleteSuccess=true");
        } else {
            response.sendRedirect("InquiryGetAllServlet?deleteError=true");
        }
    }
}
