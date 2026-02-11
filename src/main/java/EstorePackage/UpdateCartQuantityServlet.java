package EstorePackage;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateCartQuantityServlet")
public class UpdateCartQuantityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id")); // Product ID
        int change = Integer.parseInt(request.getParameter("change")); // +1 or -1

        HttpSession session = request.getSession();
        ArrayList<CartModel> cartList = (ArrayList<CartModel>) session.getAttribute("cart-list");

        if (cartList != null) {
            for (CartModel item : cartList) {
                if (item.getId() == id) {
                    // Get the current product stock from the database
                    ProductModel product = ProductDAO.getById(id).get(0);
                    int currentStock = product.getQuantity();

                    // Calculate the new quantity
                    int newQuantity = item.getQuantity() + change;

                    // Check if the new quantity exceeds the available stock
                    if (change > 0 && newQuantity > currentStock) {
                        response.getWriter().write("Insufficient Stock");
                        return; // Stop further execution
                    }

                    // Ensure quantity is not negative
                    if (newQuantity > 0) {
                        item.setQuantity(newQuantity);
                    } else {
                        response.getWriter().write("Quantity cannot be less than 1");
                        return; // Stop further execution
                    }

                    // Update the product stock in the database
                    ProductDAO.updateStock(id, currentStock - change);

                    break;
                }
            }

            // Recalculate the grand total
            double grandTotal = CartDAO.calculateTotal(cartList);
            session.setAttribute("grandTotal", grandTotal);

            // Return a success response
            response.getWriter().write("Quantity updated!");
        }
    }
}