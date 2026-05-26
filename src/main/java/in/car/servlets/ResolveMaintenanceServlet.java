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

import in.car.dbcon.DbConnection;

@WebServlet("/resolvemaintenance")

public class ResolveMaintenanceServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int maintenanceId =
                    Integer.parseInt(
                            request.getParameter("maintenance_id")
                    );

            Connection con =
                    DbConnection.getConnection();

            String fetchQuery =
                    "SELECT car_id FROM maintenance WHERE maintenance_id=?";

            PreparedStatement pst1 =
                    con.prepareStatement(fetchQuery);

            pst1.setInt(1, maintenanceId);

            ResultSet rs =
                    pst1.executeQuery();

            int carId = 0;

            if(rs.next()){

                carId =
                        rs.getInt("car_id");
            }

            String maintenanceQuery =
                    "UPDATE maintenance SET resolved=1 WHERE maintenance_id=?";

            PreparedStatement pst2 =
                    con.prepareStatement(maintenanceQuery);

            pst2.setInt(1, maintenanceId);

            pst2.executeUpdate();

            String carQuery =
                    "UPDATE car SET status='Available' WHERE car_id=?";

            PreparedStatement pst3 =
                    con.prepareStatement(carQuery);

            pst3.setInt(1, carId);

            pst3.executeUpdate();

            response.sendRedirect("maintenance.jsp");

        } catch(Exception e){

            response.setContentType("text/html");

            e.printStackTrace(response.getWriter());
        }
    }
}