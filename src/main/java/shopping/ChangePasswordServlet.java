package shopping;

import java.io.IOException;
import connect.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        try (Connection con = DBConnection.getConnection()) {
            String query = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, newPassword); // Remember to hash the password before saving it
            ps.setString(2, email);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                // Password updated successfully
                request.setAttribute("message", "Password changed successfully! You can now login.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                // Something went wrong
                request.setAttribute("errorMessage", "Failed to change password. Please try again.");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server error. Please try again later.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        }
    }
}
