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
import jakarta.servlet.http.HttpSession;

import in.car.dbcon.DbConnection;

@WebServlet("/login")

public class LoginServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection con = DbConnection.getConnection();

            String query =
                    "SELECT * FROM customer WHERE email=? AND password=?";

            PreparedStatement pst = con.prepareStatement(query);

            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();

               session.setAttribute(
        "customerName",
        rs.getString("name")
);

               session.setAttribute(
        "customerId",
        rs.getInt("customer_id")
);

                response.sendRedirect("dashboard.jsp");

            } else {

                out.println("<h1>Invalid Email or Password</h1>");
            }

        } catch (Exception e) {

            out.println("<h1>Error Occurred</h1>");

            e.printStackTrace(out);
        }
    }
}