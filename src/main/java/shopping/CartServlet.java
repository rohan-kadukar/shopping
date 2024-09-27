package shopping;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import connect.DBConnection; // Import your DBConnection class
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CartServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try (Connection con = DBConnection.getConnection()) {
            if ("add".equals(action)) {
                String productId = request.getParameter("productId");
                addToCart(con, userId, Integer.parseInt(productId));
            } else if ("remove".equals(action)) {
                String productId = request.getParameter("productId");
                removeFromCart(con, userId, Integer.parseInt(productId));
            } else if ("buy".equals(action) || "checkoutAll".equals(action)) {
                double totalPrice = 0;
                if ("buy".equals(action)) {
                    String productId = request.getParameter("productId");
                    // Retrieve quantity and calculate totalPrice
                    String quantityQuery = "SELECT quantity FROM cart_items WHERE user_id = ? AND product_id = ?";
                    try (PreparedStatement quantityStmt = con.prepareStatement(quantityQuery)) {
                        quantityStmt.setInt(1, userId);
                        quantityStmt.setInt(2, Integer.parseInt(productId));
                        try (ResultSet rs = quantityStmt.executeQuery()) {
                            if (rs.next()) {
                                int quantity = rs.getInt("quantity");
                                totalPrice = getTotalPrice(con, Integer.parseInt(productId), quantity);
                            }
                        }
                    }
                    request.setAttribute("totalPrice", totalPrice);
                } else {
                    // Handle checkoutAll, calculate total price of all items in the cart
                    totalPrice = getTotalPriceForAll(con, userId);
                    request.setAttribute("totalPrice", totalPrice);
                }
                request.getRequestDispatcher("paymentOptions.jsp").forward(request, response);
                return;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL error while processing the cart", e);
            response.sendRedirect("error.jsp");
            return;
        } catch (ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "DB Connection class not found", ex);
            response.sendRedirect("error.jsp");
            return;
        }

        response.sendRedirect("cart.jsp");
    }

    private void addToCart(Connection con, int userId, int productId) throws SQLException {
        // Check if the product is already in the cart
        String checkCartSql = "SELECT id, quantity FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement checkStmt = con.prepareStatement(checkCartSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    // If the product is already in the cart, update the quantity
                    int cartId = rs.getInt("id");
                    int currentQuantity = rs.getInt("quantity");
                    updateCartQuantity(con, cartId, currentQuantity + 1);
                } else {
                    // If the product is not in the cart, insert a new entry
                    insertNewCartItem(con, userId, productId);
                }
            }
        }
    }

    private void updateCartQuantity(Connection con, int cartId, int newQuantity) throws SQLException {
        String updateSql = "UPDATE cart_items SET quantity = ? WHERE id = ?";
        try (PreparedStatement updateStmt = con.prepareStatement(updateSql)) {
            updateStmt.setInt(1, newQuantity);
            updateStmt.setInt(2, cartId);
            updateStmt.executeUpdate();
        }
    }

    private void insertNewCartItem(Connection con, int userId, int productId) throws SQLException {
        String insertSql = "INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?)";
        try (PreparedStatement insertStmt = con.prepareStatement(insertSql)) {
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, productId);
            insertStmt.setInt(3, 1); // Default quantity is 1
            insertStmt.executeUpdate();
        }
    }

    private void removeFromCart(Connection con, int userId, int productId) throws SQLException {
        String deleteSql = "DELETE FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement deleteStmt = con.prepareStatement(deleteSql)) {
            deleteStmt.setInt(1, userId);
            deleteStmt.setInt(2, productId);
            deleteStmt.executeUpdate();
//            System.out.println("Removing productId: " + productId + " for userId: " + userId);
        }
    }

//    private void processCheckoutItem(Connection con, int userId, int productId, int quantity) throws SQLException {
//        // Insert the order into the orders table
//        String insertOrderSql = "INSERT INTO orders (user_id, product_id, quantity) VALUES (?, ?, ?)";
//        try (PreparedStatement insertOrderStmt = con.prepareStatement(insertOrderSql)) {
//            insertOrderStmt.setInt(1, userId);
//            insertOrderStmt.setInt(2, productId);
//            insertOrderStmt.setInt(3, quantity);
//            insertOrderStmt.executeUpdate();
//        }
//
//        // Remove the item from the cart
//        removeFromCart(con, userId, productId);
//    }

//    private void processCheckoutAll(Connection con, int userId) throws SQLException {
//        // Get all items from the cart for this user
//        String selectCartSql = "SELECT product_id, quantity FROM cart_items WHERE user_id = ?";
//        try (PreparedStatement selectStmt = con.prepareStatement(selectCartSql)) {
//            selectStmt.setInt(1, userId);
//            try (ResultSet rs = selectStmt.executeQuery()) {
//                while (rs.next()) {
//                    int productId = rs.getInt("product_id");
//                    int quantity = rs.getInt("quantity");
//                    // Insert each item into the orders table
//                    processCheckoutItem(con, userId, productId, quantity);
//                }
//            }
//        }
//    }
    
// Helper methods to calculate total prices

    private double getTotalPrice(Connection con, int productId, int quantity) throws SQLException {
        String sql = "SELECT price FROM products WHERE id = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("price") * quantity;
                }
            }
        }
        return 0;
    }

    private double getTotalPriceForAll(Connection con, int userId) throws SQLException {
        double total = 0;
        String sql = "SELECT products.price, cart_items.quantity FROM cart_items JOIN products ON cart_items.product_id = products.id WHERE cart_items.user_id = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    total += rs.getDouble("price") * rs.getInt("quantity");
                }
            }
        }
        return total;
    }
}
