package in.car.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import in.car.dbcon.DbConnection;

@WebServlet("/bookcar")
public class BookCarServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)

            throws ServletException, IOException {

        try {

            HttpSession session =
                    request.getSession();

            int customerId =
                    Integer.parseInt(
                            session.getAttribute("customerId").toString()
                    );

            int carId =
                    Integer.parseInt(
                            request.getParameter("car_id")
                    );

            String pickupDate =
                    request.getParameter("pickup_date");

            String returnDate =
                    request.getParameter("return_date");

            Connection con =
                    DbConnection.getConnection();

            String rateQuery =
                    "SELECT daily_rate FROM car WHERE car_id=?";

            PreparedStatement ratePst =
                    con.prepareStatement(rateQuery);

            ratePst.setInt(1, carId);

            ResultSet rs =
                    ratePst.executeQuery();

            double dailyRate = 0;

            if (rs.next()) {

                dailyRate =
                        rs.getDouble("daily_rate");
            }

            java.time.LocalDate pickup =
                    java.time.LocalDate.parse(pickupDate);

            java.time.LocalDate ret =
                    java.time.LocalDate.parse(returnDate);

            long days =
                    java.time.temporal.ChronoUnit.DAYS.between(
                            pickup,
                            ret
                    );

            if(days <= 0){

                days = 1;
            }

            double totalAmount =
                    days * dailyRate;

            String insertBooking =
                    "INSERT INTO booking(" +
                    "customer_id," +
                    "car_id," +
                    "pickup_date," +
                    "return_date," +
                    "status," +
                    "total_amount" +
                    ") VALUES(?,?,?,?,?,?)";

            PreparedStatement pst =
                    con.prepareStatement(insertBooking);

            pst.setInt(1, customerId);

            pst.setInt(2, carId);

            pst.setString(3, pickupDate);

            pst.setString(4, returnDate);

            pst.setString(5, "Active");

            pst.setDouble(6, totalAmount);

            int rows =
                    pst.executeUpdate();

            if (rows > 0) {

                String updateCar =
                        "UPDATE car " +
                        "SET status='Rented' " +
                        "WHERE car_id=?";

                PreparedStatement updatePst =
                        con.prepareStatement(updateCar);

                updatePst.setInt(1, carId);

                updatePst.executeUpdate();

response.setContentType("text/html");

response.getWriter().println(

"<!DOCTYPE html>" +

"<html>" +

"<head>" +

"<title>Booking Successful</title>" +

"<meta name='viewport' content='width=device-width, initial-scale=1'>" +

"<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet'>" +

"<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css'>" +

"<style>" +

"body{" +
"height:100vh;" +
"display:flex;" +
"justify-content:center;" +
"align-items:center;" +
"background:linear-gradient(135deg,#1e3a8a,#2563eb);" +
"font-family:Segoe UI,sans-serif;" +
"}" +

".success-card{" +
"background:white;" +
"width:500px;" +
"padding:50px;" +
"border-radius:24px;" +
"text-align:center;" +
"box-shadow:0px 10px 35px rgba(0,0,0,0.25);" +
"}" +

".success-icon{" +
"font-size:75px;" +
"color:#22c55e;" +
"margin-bottom:20px;" +
"}" +

".booking-details{" +
"background:#f8fafc;" +
"padding:20px;" +
"border-radius:14px;" +
"margin-bottom:30px;" +
"text-align:left;" +
"}" +

".btn-dashboard{" +
"background:#2563eb;" +
"color:white;" +
"padding:14px 28px;" +
"border-radius:10px;" +
"text-decoration:none;" +
"font-weight:600;" +
"}" +

"</style>" +

"</head>" +

"<body>" +

"<div class='success-card'>" +

"<div class='success-icon'>" +
"<i class='fa-solid fa-circle-check'></i>" +
"</div>" +

"<h1>Booking Successful</h1>" +

"<p>Your car has been booked successfully.</p>" +

"<div class='booking-details'>" +

"<h5>Booking Summary</h5>" +

"<p><strong>Pickup Date:</strong> " + pickupDate + "</p>" +

"<p><strong>Return Date:</strong> " + returnDate + "</p>" +

"<p><strong>Total Days:</strong> " + days + "</p>" +

"<p><strong>Total Amount:</strong> &#8377;" + totalAmount + "</p>" +
"</div>" +

"<a href='mybookings.jsp' class='btn-dashboard'>" +
"View My Bookings" +
"</a>" +

"</div>" +

"</body>" +

"</html>"

);
            } else {

                response.getWriter().println(
                        "Booking Failed"
                );
            }

        }

        catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error: " + e.getMessage()
            );
        }
    }
}