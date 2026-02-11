package EstorePackage;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
  

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get the names given with name attribute in JSP form
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		String gmail=request.getParameter("gmail");
		String password=request.getParameter("pw");
		String phone=request.getParameter("phone");
		String role=request.getParameter("role");
		
		//pass these to DButil
		boolean isTrue;
		isTrue=UserDbUtil.updateuser(id, name, gmail,password,phone,role);
		//isTrue will be T/F based on isSuccess returned from UserDbUtil
		
		if(isTrue==true) {
			 response.sendRedirect("manageusers.jsp");
		}
		else {
			List<User> userDetails= UserDbUtil.getUser(id);
			request.setAttribute("userInfo",userDetails);
			
			//it'll navigate to updateUser with previous data
			RequestDispatcher dis = request.getRequestDispatcher("updateUser.jsp");
			dis.forward(request, response);
		}
	}

}
