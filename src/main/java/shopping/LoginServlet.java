package shopping;

import java.io.IOException;
import connect.DBConnection;
import data.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) { // Use try-with-resources for automatic resource management
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Assume a method to validate password, e.g., using bcrypt for hashing
                if (validatePassword(password, rs.getString("password"))) { // Replace with actual password hash
                    int userId = rs.getInt("id");
                    String userName = rs.getString("name");
                    String userEmail = rs.getString("email");
                    User user = new User(userId,userName,userEmail);
                    HttpSession session = request.getSession();
                    session.setAttribute("userData", user);
                    session.setAttribute("user", rs.getString("name"));
                    session.setAttribute("user_id", rs.getInt("id")); // Store user ID if needed
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=1"); // Invalid password
                }
            } else {
                response.sendRedirect("login.jsp?error=1"); // Invalid email
            }
        } catch (IOException | ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=2"); // Redirect with a different error code for server error
        }
    }

    // Example method to validate password (you should implement actual hashing/validation logic)
    private boolean validatePassword(String rawPassword, String hashedPassword) {
        // Use a hashing library like BCrypt to check the password
        // For now, simply comparing raw password with hashed password directly (not secure)
        return rawPassword.equals(hashedPassword); // Replace with secure comparison
    }
}