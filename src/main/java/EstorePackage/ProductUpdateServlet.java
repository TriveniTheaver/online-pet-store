package EstorePackage;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import UserPackage.SessionUtil;

@WebServlet("/ProductUpdateServlet")
public class ProductUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check for product manager role
	    if (!SessionUtil.validateRole(request, response, "productmanager")) {
	        return;
	    }
	    try {
	        int id = Integer.parseInt(request.getParameter("id"));  
	        String name = request.getParameter("name");
	        String price = request.getParameter("price");
	        String category = request.getParameter("category");
	        int quantity = Integer.parseInt(request.getParameter("quantity"));
	        String description = request.getParameter("description");
	        String imageUrl = request.getParameter("imageUrl");

	        
	        // validation check before update using the model
	        if (!ProductModel.isValidUpdate(id, name, price, quantity)) {
	            response.getWriter().println("<script>alert('Invalid product data! Check your inputs.'); history.back();</script>");
	            return;
	        }
	        
	        // Call the update function
	        boolean isTrue = ProductDAO.updateData(id, name, price, category, quantity, description, imageUrl);

	        if (isTrue) {
	            // Data updated successfully
	            List<ProductModel> productdetails = ProductDAO.getById(id);
	            request.setAttribute("productdetails", productdetails);
	            String alertMessage = "Data updated successfully";
	            response.getWriter().println("<script> alert('" + alertMessage + "'); window.location.href='ProductGetAllServlet'</script>");
	        } else {
	            // Something went wrong with the update
	            RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
	            dis2.forward(request, response);
	        }
	    } catch (NumberFormatException e) {
	        // Handle the error if the ID parameter is not a valid number
	        response.getWriter().println("<script> alert('Invalid ID format'); window.location.href='ProductGetAllServlet'</script>");
	    } catch (Exception e) {
	        // Handles any other errors
	        e.printStackTrace();
	        response.getWriter().println("<script> alert('Error occurred while updating the data'); window.location.href='ProductGetAllServlet'</script>");
	    }
	}


}
