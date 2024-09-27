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

        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (validatePassword(password, rs.getString("password"))) {
                    HttpSession session = request.getSession();
                    User user = new User(rs.getInt("id"), rs.getString("name"), rs.getString("email"));
                    session.setAttribute("userData", user);
                    session.setAttribute("user", rs.getString("name"));
                    session.setAttribute("user_id", rs.getInt("id"));

                    response.sendRedirect("index.jsp");
                } else {
                    // Invalid password
                    request.setAttribute("errorMessage", "Invalid password. Please try again.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                // Invalid email
                request.setAttribute("errorMessage", "Invalid email address. Please try again.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (IOException | ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server error. Please try again later.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private boolean validatePassword(String rawPassword, String hashedPassword) {
        return rawPassword.equals(hashedPassword); // Replace with secure comparison
    }
}
