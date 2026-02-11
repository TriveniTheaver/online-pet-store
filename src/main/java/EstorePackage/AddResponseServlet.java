package EstorePackage;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddResponseServlet")
public class AddResponseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int inquiryId = Integer.parseInt(request.getParameter("id"));
        String responseText = request.getParameter("response");
        
        boolean isSuccess = InquiryDAO.addResponse(inquiryId, responseText);
        
        if (isSuccess) {
            response.sendRedirect("InquiryGetAllServlet?responseSuccess=true");
        } else {
            response.sendRedirect("InquiryGetAllServlet?responseError=true");
        }
    }
}
