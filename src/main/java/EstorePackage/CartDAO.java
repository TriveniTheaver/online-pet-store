package EstorePackage;

import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Add a product to the cart
    public static void addToCart(List<CartModel> cartList, CartModel item) {
        boolean itemExists = false;

        // Check if the item already exists in the cart
        for (CartModel cartItem : cartList) {
            if (cartItem.getId() == item.getId()) {
                cartItem.setQuantity(cartItem.getQuantity() + item.getQuantity()); // Update quantity
                itemExists = true;
                break;
            }
        }

        // If the item doesn't exist, add it to the cart
        if (!itemExists) {
            cartList.add(item);
        }
    }

    // Remove a product from the cart
    public static void removeFromCart(List<CartModel> cartList, int productId) {
        cartList.removeIf(item -> item.getId() == productId);
    }

    // Update the quantity of a product in the cart
    public static void updateQuantity(List<CartModel> cartList, int productId, int quantity) {
        for (CartModel item : cartList) {
            if (item.getId() == productId) {
                item.setQuantity(quantity);
                break;
            }
        }
    }

 // Calculate the total price of the cart
    public static double calculateTotal(List<CartModel> cartList) {
        double total = 0.0;
        for (CartModel item : cartList) {
            total += item.getQuantity() * Double.parseDouble(item.getPrice());
        }
        return total;
    }
}
