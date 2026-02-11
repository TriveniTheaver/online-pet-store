package EstorePackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import EstorePackage.InquiryModel;
import EstorePackage.InquiryDAO;
import UserPackage.SessionUtil;

@WebServlet("/EditInquiryServlet")
public class EditInquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!SessionUtil.validateRole(request, response, "customer")) {
            return;
        }

        try {
            int inquiryId = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession(false);
            Integer customerId = (Integer) session.getAttribute("userId");

            InquiryModel inquiry = InquiryDAO.getInquiryById(inquiryId);

            // Verify inquiry exists and belongs to this customer
            if (inquiry == null || inquiry.getCustomerId() != customerId) {
                response.sendRedirect("CustomerInquiryServlet?error=not_found");
                return;
            }

            request.setAttribute("inquiry", inquiry);
            request.getRequestDispatcher("EditInquiry.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("CustomerInquiryServlet?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CustomerInquiryServlet?error=server_error");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (!SessionUtil.validateRole(request, response, "customer")) {
            return;
        }

        try {
            request.setCharacterEncoding("UTF-8");
            HttpSession session = request.getSession(false);
            Integer customerId = (Integer) session.getAttribute("userId");

            int id = Integer.parseInt(request.getParameter("id"));
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            // Basic validation
            if (subject == null || subject.trim().isEmpty() || 
                message == null || message.trim().isEmpty()) {
                response.sendRedirect("EditInquiryServlet?id=" + id + "&error=empty_fields");
                return;
            }

            // Update the inquiry (customer can only update subject and message)
            boolean success = InquiryDAO.updateInquiry(
                id, customerId, subject.trim(), message.trim());

            if (success) {
                response.sendRedirect("CustomerInquiryServlet?updateSuccess=true");
            } else {
                response.sendRedirect("EditInquiryServlet?id=" + id + "&updateError=true");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("CustomerInquiryServlet?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CustomerInquiryServlet?error=server_error");
        }
    }
}