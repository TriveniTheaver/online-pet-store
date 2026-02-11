package EstorePackage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import UserPackage.SessionUtil;

@WebServlet("/ProductInsertServlet")
public class ProductInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			// Check for product manager role for request processing
		    if (!SessionUtil.validateRole(request, response, "productmanager")) {
		        return;
		    }
		    
		try {   
		    
			String name=request.getParameter("name");
			String price=request.getParameter("price");
			String category=request.getParameter("category");
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			String description=request.getParameter("description");
			String imageUrl = request.getParameter("imageUrl"); 
			
			
			// validation check using the product model
		    if (!ProductModel.isValidProduct(name, price, quantity)) {
		        response.getWriter().println("<script>alert('Invalid data! Check price/quantity.'); history.back();</script>");
		        return; // Stops execution if invalid
		    }
	
		    // Proceed with DAO insertion if valid-call dao to insert
		    boolean isInserted = ProductDAO.insertdata(name, price, category, quantity, description, imageUrl);
			
			
			//response
			if(isInserted==true) {
				String alertMessage="Data inserted successfully";
				response.getWriter().println("<script> alert('"+alertMessage+"'); window.location.href='ProductGetAllServlet'</script>");
				
			}else {
				RequestDispatcher dis2=request.getRequestDispatcher("wrong.jsp");
				dis2.forward(request, response);
			}
			
			
		} catch(NumberFormatException e) {
	        // Specific handling for number conversion
	        response.getWriter().println("<script>alert('Quantity must be a number!'); history.back();</script>");
		}
		//catches any other  exceptions
		catch (Exception e) {
		    e.printStackTrace();
		    response.getWriter().println("<script>alert('System error saving product'); window.location.href='addProduct.jsp'</script>");
		}
	}

}
