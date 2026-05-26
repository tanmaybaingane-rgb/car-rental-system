package in.car.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import in.car.dbcon.DbConnection;

@WebServlet("/addcar")

public class AddCarServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out =
                response.getWriter();

        try {

            String carModel =
                    request.getParameter("car_model");

            String category =
                    request.getParameter("category");

            double dailyRate =
                    Double.parseDouble(
                            request.getParameter("daily_rate")
                    );

            String fuelType =
                    request.getParameter("fuel_type");

            String registrationNo =
                    request.getParameter("registration_no");

            int seats =
                    Integer.parseInt(
                            request.getParameter("seats")
                    );

            Connection con =
                    DbConnection.getConnection();

            String query =
                    "INSERT INTO car(car_model,category,daily_rate,status,fuel_type,registration_no,seats) VALUES(?,?,?,?,?,?,?)";

            PreparedStatement pst =
                    con.prepareStatement(query);

            pst.setString(1, carModel);
            pst.setString(2, category);
            pst.setDouble(3, dailyRate);
            pst.setString(4, "Available");
            pst.setString(5, fuelType);
            pst.setString(6, registrationNo);
            pst.setInt(7, seats);

            int rows =
                    pst.executeUpdate();

            if(rows > 0){

                out.println("<h1>Car Added Successfully</h1>");

            } else {

                out.println("<h1>Failed To Add Car</h1>");
            }

        } catch(Exception e){

            out.println("<h1>Error Occurred</h1>");

            e.printStackTrace(out);
        }
    }
}