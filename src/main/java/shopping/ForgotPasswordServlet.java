package shopping;

import java.io.IOException;
import connect.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Email exists; provide option to change password
                request.setAttribute("email", email);
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
            } else {
                // Email does not exist
                request.setAttribute("errorMessage", "Email not found. Please enter a registered email.");
                request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server error. Please try again later.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
        }
    }
}
