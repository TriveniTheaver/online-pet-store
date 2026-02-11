package EstorePackage;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/AddServlet")
public class AddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    String name = req.getParameter("name");//name attribute values
	    String gmail = req.getParameter("gmail");
	    String phone = req.getParameter("phone");
	    String role = req.getParameter("role");
	    String passw = req.getParameter("pw");

	    boolean isTrue;
	    User user = new User(name, gmail, passw, phone, role);
	    isTrue = UserDbUtil.addNew(user);

	    if (isTrue) {
	        RequestDispatcher dis = req.getRequestDispatcher("manageusers.jsp");
	        dis.forward(req, res);
	        System.out.println("Insertion successful");
	    } else {
	        RequestDispatcher dis2 = req.getRequestDispatcher("addnewUser.jsp");
	        dis2.forward(req, res);
	        System.out.println("Cannot Insert into DB!!");
	    }
	}
	
}
