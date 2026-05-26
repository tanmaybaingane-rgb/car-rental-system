package in.car.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import in.car.dbcon.DbConnection;

@WebServlet("/dbtest")

public class DBTestServlet extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        try {

            Connection con = DbConnection.getConnection();

            if (con != null) {

                out.println("<h1>Database Connected Successfully</h1>");

            } else {

                out.println("<h1>Database Connection Failed</h1>");
            }

        } catch (Exception e) {

            out.println("<h1>Error Occurred</h1>");

            e.printStackTrace(out);
        }
    }
}