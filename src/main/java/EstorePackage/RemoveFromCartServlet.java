package EstorePackage;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id")); // Product ID

        HttpSession session = request.getSession();
        ArrayList<CartModel> cartList = (ArrayList<CartModel>) session.getAttribute("cart-list");

        if (cartList != null) {
            for (CartModel item : cartList) {
                if (item.getId() == id) {
                    // Get the current product stock from the database
                    ProductModel product = ProductDAO.getById(id).get(0);
                    int currentStock = product.getQuantity();

                    // Restore the stock by adding the removed quantity back
                    int restoredStock = currentStock + item.getQuantity();
                    ProductDAO.updateStock(id, restoredStock);

                    // Remove the item from the cart
                    cartList.remove(item);
                    break;
                }
            }

            // Recalculate the grand total
            double grandTotal = CartDAO.calculateTotal(cartList);
            session.setAttribute("grandTotal", grandTotal);

            // Debugging: Print the updated stock and cart list
            System.out.println("Stock restored for Product ID " + id);
            System.out.println("Updated Cart List: " + cartList);
        }

        // Redirect to Cart.jsp
        response.sendRedirect("Cart.jsp");
    }
}