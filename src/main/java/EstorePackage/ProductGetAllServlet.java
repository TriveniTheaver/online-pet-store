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

//read function
@WebServlet("/ProductGetAllServlet")
public class ProductGetAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Checks for product manager role
	    if (!SessionUtil.validateRole(request, response, "productmanager")) {
	        return;
	    }
	    try {
	        List<ProductModel> allProducts = ProductDAO.getAllProduct();
	        
	        if (allProducts == null || allProducts.isEmpty()) {
	            System.out.println("No products found!"); 
	        } else {
	            System.out.println("Products fetched: " + allProducts.size()); 
	        }

	        request.setAttribute("allProducts", allProducts);
	        RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayProductDetails.jsp");
	        dispatcher.forward(request, response);
	        
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().println("<script>alert('Error loading products'); window.location.href='ProductGetAllServlet'</script>");
	    }
	}

	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 doGet(request,response);
	}

	
}
