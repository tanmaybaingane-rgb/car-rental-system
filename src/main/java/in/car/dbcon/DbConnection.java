package in.car.dbcon;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/car_rental_db";

    private static final String USER = "root";

    // CHANGE THIS TO YOUR MYSQL PASSWORD
    private static final String PASSWORD = "Tanmay19#";

    public static Connection getConnection() {

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

            System.out.println("Database Connected Successfully");

        } catch (Exception e) {

            System.out.println("Database Connection Failed");
            e.printStackTrace();
        }

        return con;
    }
}