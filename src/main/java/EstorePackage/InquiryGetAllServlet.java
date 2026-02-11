package EstorePackage;


import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InquiryGetAllServlet")
public class InquiryGetAllServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<InquiryModel> inquiries = InquiryDAO.getAllInquiries();
        request.setAttribute("inquiries", inquiries);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("SupportInquiries.jsp");
        dispatcher.forward(request, response);
    }
}