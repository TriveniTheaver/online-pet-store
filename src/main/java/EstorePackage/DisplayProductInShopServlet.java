package EstorePackage;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DisplayProductInShopServlet")
public class DisplayProductInShopServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
		
			protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				List <ProductModel> allProducts = ProductDAO.getAllProduct();
				request.setAttribute("allProducts", allProducts);
				
				RequestDispatcher dispatcher=request.getRequestDispatcher("Shop.jsp");
				dispatcher.forward(request, response);
			}

		
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			 
			doGet(request,response);
		}

   
	
	
}
