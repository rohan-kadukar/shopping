<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Payment</title>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .payment-container {
            max-width: 600px;
            margin: auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        .payment-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .payment-option {
            border: 2px solid #007bff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .payment-option:hover {
            background-color: #e9f5ff;
            border-color: #0056b3;
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            margin-top: 10px;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .payment-info {
            margin-top: 20px;
            display: none;
        }
    </style>
    <script>
        function showPaymentInfo(paymentType) {
            const paymentInfoDivs = document.querySelectorAll('.payment-info');
            paymentInfoDivs.forEach(div => div.style.display = 'none');
            document.getElementById(paymentType + 'Info').style.display = 'block';
        }

        function showOrderNow() {
            const orderNowButton = document.getElementById('orderNowButton');
            const paymentInfoDivs = document.querySelectorAll('.payment-info');
            paymentInfoDivs.forEach(div => div.style.display = 'none'); // Hide all payment info when ordering
            orderNowButton.style.display = 'block';
        }

        function resetPaymentOptions() {
            const orderNowButton = document.getElementById('orderNowButton');
            orderNowButton.style.display = 'none'; // Hide Order Now button
            const paymentInfoDivs = document.querySelectorAll('.payment-info');
            paymentInfoDivs.forEach(div => div.style.display = 'none'); // Hide all payment info
        }

        function selectPaymentMethod(method) {
            resetPaymentOptions(); // Reset all states before showing new options

            if (method === 'payOnDelivery') {
                showOrderNow();
            } else if (method === 'payNow') {
                document.getElementById('payNowInfo').style.display = 'block'; // Show pay now options
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="payment-container">
            <div class="payment-header">
                <h2>Choose Your Payment Method</h2>
                <p>Select your preferred method below:</p>
            </div>

            <div class="payment-option" onclick="selectPaymentMethod('payOnDelivery')">
                <strong>Pay on Delivery</strong>
            </div>
            <div class="payment-option" onclick="selectPaymentMethod('payNow')">
                <strong>Pay Now</strong>
            </div>

            <div id="orderNowButton" style="display: none;">
                <form action="PaymentServlet" method="post">
                    <input type="hidden" name="paymentMethod" value="Pay on Delivery">
                    <button type="submit" class="btn btn-custom btn-block">Order Now</button>
                </form>
            </div>

            <div id="paymentInfo">
                <div id="payNowInfo" class="payment-info">
                    <h4>Select a Payment Method</h4>
                    <div class="row">
                        <div class="col-md-3">
                            <button type="button" class="btn btn-custom w-100" onclick="showPaymentInfo('upi')">UPI ID</button>
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-custom w-100" onclick="showPaymentInfo('qr')">QR Code</button>
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-custom w-100" onclick="showPaymentInfo('debit')">Debit Card</button>
                        </div>
                        <div class="col-md-3">
                            <button type="button" class="btn btn-custom w-100" onclick="showPaymentInfo('netbanking')">Net Banking</button>
                        </div>
                    </div>
                </div>

                <div id="upiInfo" class="payment-info">
                    <h4>Enter Your UPI ID</h4>
                    <form action="PaymentServlet" method="post">
                        <input type="hidden" name="paymentMethod" value="UPI">
                        <div class="form-group">
                            <input type="text" name="upiId" class="form-control" placeholder="example@upi" required>
                        </div>
                        <button type="submit" class="btn btn-custom btn-block">Pay</button>
                    </form>
                </div>

                <div id="qrInfo" class="payment-info">
                    <h4>Scan QR Code</h4>
                    <p>Use the QR code below to complete your payment:</p>
                    <img src="https://via.placeholder.com/150" alt="Sample QR Code" class="img-fluid" />
                    <form action="PaymentServlet" method="post">
                        <input type="hidden" name="paymentMethod" value="QR Code">
                        <button type="submit" class="btn btn-custom btn-block">Pay</button>
                    </form>
                </div>

                <div id="debitInfo" class="payment-info">
                    <h4>Debit Card Details</h4>
                    <form action="PaymentServlet" method="post">
                        <input type="hidden" name="paymentMethod" value="Debit Card">
                        <div class="form-group">
                            <label>Card Number:</label>
                            <input type="text" name="debitCardNumber" class="form-control" placeholder="Enter Card Number" required>
                        </div>
                        <div class="form-group">
                            <label>Expiry Date (MM/YY):</label>
                            <input type="text" name="debitCardExpiry" class="form-control" placeholder="MM/YY" required>
                        </div>
                        <div class="form-group">
                            <label>CVV:</label>
                            <input type="text" name="debitCardCVV" class="form-control" placeholder="Enter CVV" required>
                        </div>
                        <button type="submit" class="btn btn-custom btn-block">Pay</button>
                    </form>
                </div>

                <div id="netbankingInfo" class="payment-info">
                    <h4>Net Banking Details</h4>
                    <form action="PaymentServlet" method="post">
                        <input type="hidden" name="paymentMethod" value="Net Banking">
                        <div class="form-group">
                            <label>Select Your Bank:</label>
                            <select name="bankSelect" class="form-control" required>
                                <option value="">Select Bank</option>
                                <option value="bank1">Bank 1</option>
                                <option value="bank2">Bank 2</option>
                                <option value="bank3">Bank 3</option>
                                <option value="bank4">Bank 4</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Username:</label>
                            <input type="text" name="netBankingUser" class="form-control" placeholder="Enter Username" required>
                        </div>
                        <div class="form-group">
                            <label>Password:</label>
                            <input type="password" name="netBankingPassword" class="form-control" placeholder="Enter Password" required>
                        </div>
                        <button type="submit" class="btn btn-custom btn-block">Pay</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
