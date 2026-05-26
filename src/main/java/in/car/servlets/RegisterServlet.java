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

@WebServlet("/register")

public class RegisterServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String license = request.getParameter("license");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        try {

            Connection con = DbConnection.getConnection();

            String query =
                    "INSERT INTO customer(name,email,phone,license_no,address,password) VALUES(?,?,?,?,?,?)";

            PreparedStatement pst = con.prepareStatement(query);

            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, phone);
            pst.setString(4, license);
            pst.setString(5, address);
            pst.setString(6, password);

            int rows = pst.executeUpdate();

            if (rows > 0) {

                out.println("<h1>Registration Successful</h1>");

            } else {

                out.println("<h1>Registration Failed</h1>");
            }

        } catch (Exception e) {

            out.println("<h1>Error Occurred</h1>");

            e.printStackTrace(out);
        }
    }
}