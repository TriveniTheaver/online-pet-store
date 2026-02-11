package EstorePackage;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id")); // Product ID
            String name = request.getParameter("name");
            String price = request.getParameter("price");
            String imageUrl = request.getParameter("imageUrl");

            // Get the product from the database
            ProductModel product = ProductDAO.getById(id).get(0);

            // Check if the product is in stock
            if (product.getQuantity() <= 0) {
                response.getWriter().write("Out of Stock");
                return;
            }

            // Create a CartModel object
            CartModel cartItem = new CartModel(id, name, price, imageUrl, 1);

            // Get the session
            HttpSession session = request.getSession();
            ArrayList<CartModel> cartList = (ArrayList<CartModel>) session.getAttribute("cart-list");

            // If cart-list doesn't exist, create it
            if (cartList == null) {
                cartList = new ArrayList<>();
                session.setAttribute("cart-list", cartList);
            }

            // Check if the item already exists in the cart
            boolean itemExists = false;
            for (CartModel item : cartList) {
                if (item.getId() == id) {
                    item.setQuantity(item.getQuantity() + 1); // Increase quantity
                    itemExists = true;
                    break;
                }
            }

            // If the item doesn't exist, add it to the cart
            if (!itemExists) {
                cartList.add(cartItem);
            }

            // Update the product stock in the database
            ProductDAO.updateStock(id, product.getQuantity() - 1);

            // Calculate the grand total
            double grandTotal = CartDAO.calculateTotal(cartList);

            // Set the grand total in the session
            session.setAttribute("grandTotal", grandTotal);

            // Debugging: Print the cart list and grand total to the console
            System.out.println("Cart List: " + cartList);
            System.out.println("Grand Total: " + grandTotal);

            // Return a success response
            response.getWriter().write("Product added to cart!");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        }
    }
}
