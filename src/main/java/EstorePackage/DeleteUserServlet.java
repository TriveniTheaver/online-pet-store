package EstorePackage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteUserServlet")

public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    	int userId = Integer.parseInt(request.getParameter("id"));

        boolean success = UserDbUtil.deleteUser(userId);

        if (success) {
            response.sendRedirect("manageusers.jsp");
        } else {
            response.getWriter().println("Error deleting user.");
        }
    }
}