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
@WebServlet("/ProductDeleteServlet")
public class ProductDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Check for product manager role
        if (!SessionUtil.validateRole(request, response, "productmanager")) {
            return;
        }
        try {
            // Convert id from String to integer
            int id = Integer.parseInt(request.getParameter("id"));
            
            // validation check before delete
            if (!ProductModel.isValidDelete(id)) {
                response.getWriter().println("<script>alert('Invalid product ID!'); window.location.href='ProductGetAllServlet'</script>");
                return;
            }
            
            
            boolean isTrue = ProductDAO.deleteData(String.valueOf(id)); // Pass id as String to deleteData method

            if (isTrue) {
                String alertMessage = "Data Deleted Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "');" + "window.location.href='ProductGetAllServlet';</script>");
            } else {
                // Fetch product details by id to show on wrong page
                List<ProductModel> productDetails = ProductDAO.getById(id); // Pass id as int to getById
                request.setAttribute("productDetails", productDetails);

                RequestDispatcher dispatcher = request.getRequestDispatcher("wrong.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Invalid ID format'); window.location.href='ProductGetAllServlet'</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error occurred while deleting the data'); window.location.href='ProductGetAllServlet'</script>");
        }
    }
}
