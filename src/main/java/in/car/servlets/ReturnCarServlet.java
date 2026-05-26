package in.car.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import in.car.dbcon.DbConnection;

@WebServlet("/returncar")

public class ReturnCarServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {

            int bookingId =
                    Integer.parseInt(
                            request.getParameter("booking_id")
                    );

            String description =
                    request.getParameter("description");

            String maintenanceRequired =
                    request.getParameter("maintenance_required");

            // FIXED SECTION
            double cost = 0;

            String costParam =
                    request.getParameter("cost");

            if (costParam != null &&
                    !costParam.trim().isEmpty()) {

                cost = Double.parseDouble(costParam);
            }

            Connection con =
                    DbConnection.getConnection();

            String bookingQuery =
                    "SELECT car_id, return_date, total_amount " +
                    "FROM booking WHERE booking_id=?";

            PreparedStatement pst1 =
                    con.prepareStatement(bookingQuery);

            pst1.setInt(1, bookingId);

            ResultSet rs =
                    pst1.executeQuery();

            int carId = 0;

            java.sql.Date returnDate = null;

            double totalAmount = 0;

            if(rs.next()){

                carId =
                        rs.getInt("car_id");

                returnDate =
                        rs.getDate("return_date");

                totalAmount =
                        rs.getDouble("total_amount");
            }

            java.time.LocalDate today =
                    java.time.LocalDate.now();

            java.time.LocalDate expectedReturn =
                    returnDate.toLocalDate();

            long lateDays =
                    java.time.temporal.ChronoUnit.DAYS
                            .between(expectedReturn, today);

            double lateFee = 0;

            if(lateDays > 0){

                lateFee = lateDays * 500;

                totalAmount += lateFee;
            }

            String updateBooking =
                    "UPDATE booking SET " +
                    "status='Completed', " +
                    "actual_return_date=?, " +
                    "total_amount=? " +
                    "WHERE booking_id=?";

            PreparedStatement pst2 =
                    con.prepareStatement(updateBooking);

            pst2.setDate(
                    1,
                    java.sql.Date.valueOf(today)
            );

            pst2.setDouble(2, totalAmount);

            pst2.setInt(3, bookingId);

            pst2.executeUpdate();

            if(maintenanceRequired != null){

                String maintenanceQuery =
                        "INSERT INTO maintenance(car_id,description,maintenance_date,cost,logged_by,resolved) VALUES(?,?,?,?,?,?)";

                PreparedStatement pst3 =
                        con.prepareStatement(maintenanceQuery);

                pst3.setInt(1, carId);

                pst3.setString(
                        2,
                        description == null || description.isEmpty()
                                ? "General Maintenance"
                                : description
                );

                pst3.setDate(
                        3,
                        java.sql.Date.valueOf(today)
                );

                pst3.setDouble(4, cost);

                pst3.setString(5, "System");

                pst3.setBoolean(6, false);

                pst3.executeUpdate();

                String updateCar =
                        "UPDATE car SET status='Maintenance' WHERE car_id=?";

                PreparedStatement pst4 =
                        con.prepareStatement(updateCar);

                pst4.setInt(1, carId);

                pst4.executeUpdate();

                out.println(

"<!DOCTYPE html>" +

"<html>" +

"<head>" +

"<title>Return Complete</title>" +

"<meta name='viewport' content='width=device-width, initial-scale=1'>" +

"<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet'>" +

"<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css'>" +

"<style>" +

"body{" +
"height:100vh;" +
"display:flex;" +
"justify-content:center;" +
"align-items:center;" +
"background:linear-gradient(135deg,#0f172a,#1e3a8a);" +
"font-family:Segoe UI,sans-serif;" +
"}" +

".return-card{" +
"background:white;" +
"width:550px;" +
"padding:50px;" +
"border-radius:24px;" +
"text-align:center;" +
"box-shadow:0px 10px 35px rgba(0,0,0,0.25);" +
"}" +

".icon{" +
"font-size:75px;" +
"color:#f59e0b;" +
"margin-bottom:20px;" +
"}" +

".details{" +
"background:#f8fafc;" +
"padding:20px;" +
"border-radius:14px;" +
"margin-top:25px;" +
"margin-bottom:30px;" +
"text-align:left;" +
"}" +

".btn-home{" +
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

"<div class='return-card'>" +

"<div class='icon'>" +
"<i class='fa-solid fa-screwdriver-wrench'></i>" +
"</div>" +

"<h1>Returned & Sent To Maintenance</h1>" +

"<p>The vehicle has been returned successfully and moved to maintenance.</p>" +

"<div class='details'>" +

"<h5>Return Summary</h5>" +

"<p><strong>Late Fee:</strong> &#8377;" + lateFee + "</p>" +

"<p><strong>Total Amount:</strong> &#8377;" + totalAmount + "</p>" +

"<p><strong>Maintenance Cost:</strong> &#8377;" + cost + "</p>" +

"</div>" +

"<a href='dashboard.jsp' class='btn-home'>" +
"Go To Dashboard" +
"</a>" +

"</div>" +

"</body>" +

"</html>"

);

            } else {

                String updateCar =
                        "UPDATE car SET status='Available' WHERE car_id=?";

                PreparedStatement pst4 =
                        con.prepareStatement(updateCar);

                pst4.setInt(1, carId);

                pst4.executeUpdate();

                out.println(

"<!DOCTYPE html>" +

"<html>" +

"<head>" +

"<title>Return Successful</title>" +

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

".return-card{" +
"background:white;" +
"width:550px;" +
"padding:50px;" +
"border-radius:24px;" +
"text-align:center;" +
"box-shadow:0px 10px 35px rgba(0,0,0,0.25);" +
"}" +

".icon{" +
"font-size:75px;" +
"color:#22c55e;" +
"margin-bottom:20px;" +
"}" +

".details{" +
"background:#f8fafc;" +
"padding:20px;" +
"border-radius:14px;" +
"margin-top:25px;" +
"margin-bottom:30px;" +
"text-align:left;" +
"}" +

".btn-home{" +
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

"<div class='return-card'>" +

"<div class='icon'>" +
"<i class='fa-solid fa-circle-check'></i>" +
"</div>" +

"<h1>Car Returned Successfully</h1>" +

"<p>The vehicle return process has been completed.</p>" +

"<div class='details'>" +

"<h5>Return Summary</h5>" +

"<p><strong>Late Fee:</strong> &#8377;" + lateFee + "</p>" +

"<p><strong>Total Amount:</strong> &#8377;" + totalAmount + "</p>" +

"</div>" +

"<a href='dashboard.jsp' class='btn-home'>" +
"Go To Dashboard" +
"</a>" +

"</div>" +

"</body>" +

"</html>"

);
            }

        } catch(Exception e){

            out.println("<h1>Error Occurred</h1>");

            e.printStackTrace(out);
        }
    }
}