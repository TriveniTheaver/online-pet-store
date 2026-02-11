package EstorePackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateInquiryServlet")
public class UpdateInquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            // Get parameters
            String inquiryIdParam = request.getParameter("id");
            String responseText = request.getParameter("response");
            String status = request.getParameter("status");
            
            // Validate input
            if (inquiryIdParam == null || inquiryIdParam.trim().isEmpty()) {
                response.sendRedirect("InquiryGetAllServlet?updateError=true&message=Missing inquiry ID");
                return;
            }
            
            int inquiryId = Integer.parseInt(inquiryIdParam);
            
            if (responseText == null || responseText.trim().isEmpty()) {
                response.sendRedirect("InquiryGetAllServlet?updateError=true&message=Response is required");
                return;
            }
            
            // Update inquiry with response and status
            boolean isSuccess = InquiryDAO.addResponse(inquiryId, responseText);
            
            if (status != null && !status.trim().isEmpty()) {
                InquiryDAO.updateInquiryStatus(inquiryId, status);
            }
            
            if (isSuccess) {
                response.sendRedirect("InquiryGetAllServlet?responseSuccess=true");
            } else {
                response.sendRedirect("InquiryGetAllServlet?responseError=true");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("InquiryGetAllServlet?responseError=true&message=Invalid inquiry ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("InquiryGetAllServlet?responseError=true&message=Server error");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            String inquiryIdParam = request.getParameter("id");
            if (inquiryIdParam == null || inquiryIdParam.trim().isEmpty()) {
                response.sendRedirect("InquiryGetAllServlet?responseError=true&message=Missing inquiry ID");
                return;
            }
            
            int inquiryId = Integer.parseInt(inquiryIdParam);
            InquiryModel inquiry = InquiryDAO.getInquiryById(inquiryId);
            
            if (inquiry == null) {
                response.sendRedirect("InquiryGetAllServlet?responseError=true&message=Inquiry not found");
                return;
            }
            
            request.setAttribute("inquiry", inquiry);
            request.getRequestDispatcher("updateInquiry.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("InquiryGetAllServlet?responseError=true&message=Invalid inquiry ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("InquiryGetAllServlet?responseError=true&message=Server error");
        }
    }
}