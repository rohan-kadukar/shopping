package shopping;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import connect.DBConnection; // Adjust the import based on your project structure
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/ProcessPaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentMethod = request.getParameter("paymentMethod");
        String userId = request.getSession().getAttribute("userId").toString(); // Assuming you store userId in session

        // Prepare to store payment details
        String insertPaymentSQL = "INSERT INTO payments (user_id, payment_method, upi_id, qr_code, debit_card_number, debit_card_expiry, debit_card_cvv, bank_name, net_banking_user, net_banking_password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(insertPaymentSQL)) {

            pstmt.setString(1, userId); // User ID
            pstmt.setString(2, paymentMethod); // Payment Method

            // Set values based on payment method
            if ("payNow".equals(paymentMethod)) {
                String upiId = request.getParameter("upiId");
                String qrCode = request.getParameter("qrCode");
                String debitCardNumber = request.getParameter("debitCardNumber");
                String debitCardExpiry = request.getParameter("debitCardExpiry");
                String debitCardCVV = request.getParameter("debitCardCVV");
                String bankName = request.getParameter("bankSelect");
                String netBankingUser = request.getParameter("netBankingUser");
                String netBankingPassword = request.getParameter("netBankingPassword");

                pstmt.setString(3, upiId); // UPI ID
                pstmt.setString(4, qrCode); // QR Code
                pstmt.setString(5, debitCardNumber); // Debit Card Number
                pstmt.setString(6, debitCardExpiry); // Expiry Date
                pstmt.setString(7, debitCardCVV); // CVV
                pstmt.setString(8, bankName); // Bank Name
                pstmt.setString(9, netBankingUser); // Net Banking Username
                pstmt.setString(10, netBankingPassword); // Net Banking Password

            } else if ("payOnDelivery".equals(paymentMethod)) {
                pstmt.setString(3, null); // UPI ID
                pstmt.setString(4, null); // QR Code
                pstmt.setString(5, null); // Debit Card Number
                pstmt.setString(6, null); // Expiry Date
                pstmt.setString(7, null); // CVV
                pstmt.setString(8, null); // Bank Name
                pstmt.setString(9, null); // Net Banking Username
                pstmt.setString(10, null); // Net Banking Password
            }

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("success.jsp"); // Redirect to a success page
            } else {
                response.sendRedirect("error.jsp"); // Redirect to an error page
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Handle errors appropriately
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
