<%@ page import="java.sql.*" %>
<%@ page import="in.car.dbcon.DbConnection" %>
<%@ include file="navbar.jsp" %>

<%
    if(session.getAttribute("customerName") == null){

        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<title>Reports</title>

<link rel="stylesheet" href="css/style.css">

<style>

    .hero-section{

        background:linear-gradient(
                135deg,
                #1e3a8a,
                #2563eb
        );

        color:white;

        padding:40px;

        border-radius:24px;

        margin-bottom:35px;

        box-shadow:0px 10px 25px rgba(0,0,0,0.15);
    }

    .hero-section h1{

        color:white;

        font-size:42px;

        margin-bottom:15px;
    }

    .hero-section p{

        font-size:18px;

        opacity:0.95;
    }

    .analytics-grid{

        display:grid;

        grid-template-columns:
                repeat(auto-fit,minmax(240px,1fr));

        gap:25px;

        margin-bottom:40px;
    }

    .analytics-card{

        padding:30px;

        border-radius:22px;

        color:white;

        box-shadow:0px 8px 20px rgba(0,0,0,0.12);

        transition:0.3s;
    }

    .analytics-card:hover{

        transform:translateY(-6px);
    }

    .analytics-card h2{

        color:white;

        font-size:42px;

        margin-bottom:12px;
    }

    .analytics-card p{

        font-size:17px;

        opacity:0.95;
    }

    .table-title{

        margin-top:20px;

        margin-bottom:20px;

        font-size:30px;
    }

    .table-wrapper{

        background:white;

        border-radius:20px;

        overflow:hidden;

        box-shadow:0px 8px 20px rgba(0,0,0,0.08);
    }

</style>

</head>

<body>

<div class="container">

<div class="hero-section">

    <h1>

        Business Analytics & Reports

    </h1>

    <p>

        Monitor rental activity, revenue performance,
        maintenance expenses and operational statistics.

    </p>

</div>

<div class="analytics-grid">

<%

    try{

        Connection con =
                DbConnection.getConnection();

        Statement st =
                con.createStatement();

        ResultSet rs1 =
                st.executeQuery(
                        "SELECT COUNT(*) FROM booking"
                );

        rs1.next();

        int totalBookings =
                rs1.getInt(1);

        ResultSet rs2 =
                st.executeQuery(
                        "SELECT COUNT(*) FROM booking WHERE status='Completed'"
                );

        rs2.next();

        int completedBookings =
                rs2.getInt(1);

        ResultSet rs3 =
                st.executeQuery(
                        "SELECT COUNT(*) FROM booking WHERE status='Active'"
                );

        rs3.next();

        int activeRentals =
                rs3.getInt(1);

        ResultSet rs4 =
                st.executeQuery(
                        "SELECT IFNULL(SUM(total_amount),0) FROM booking"
                );

        rs4.next();

        double totalRevenue =
                rs4.getDouble(1);

        ResultSet rs5 =
                st.executeQuery(
                        "SELECT IFNULL(SUM(cost),0) FROM maintenance"
                );

        rs5.next();

        double maintenanceExpense =
                rs5.getDouble(1);

%>

<div class="analytics-card"
     style="
        background:linear-gradient(135deg,#2563eb,#1d4ed8);
     ">

    <h2>

        <%= totalBookings %>

    </h2>

    <p>Total Bookings</p>

</div>

<div class="analytics-card"
     style="
        background:linear-gradient(135deg,#16a34a,#15803d);
     ">

    <h2>

        <%= completedBookings %>

    </h2>

    <p>Completed Bookings</p>

</div>

<div class="analytics-card"
     style="
        background:linear-gradient(135deg,#ea580c,#c2410c);
     ">

    <h2>

        <%= activeRentals %>

    </h2>

    <p>Active Rentals</p>

</div>

<div class="analytics-card"
     style="
        background:linear-gradient(135deg,#7c3aed,#6d28d9);
     ">

    <h2>

        &#8377;
        <%= totalRevenue %>

    </h2>

    <p>Total Revenue</p>

</div>

<div class="analytics-card"
     style="
        background:linear-gradient(135deg,#dc2626,#b91c1c);
     ">

    <h2>

        &#8377;
        <%= maintenanceExpense %>

    </h2>

    <p>Maintenance Expense</p>

</div>

<%

    } catch(Exception e){

        out.println(e);
    }

%>

</div>

<h2 class="table-title">

    Booking Financial Report

</h2>

<div class="table-wrapper">

<table>

<tr>

    <th>Booking ID</th>

    <th>Customer ID</th>

    <th>Car ID</th>

    <th>Status</th>

    <th>Total Amount</th>

    <th>Booked At</th>

</tr>

<%

    try{

        Connection con =
                DbConnection.getConnection();

        String query =
                "SELECT * FROM booking " +
                "ORDER BY booking_id DESC";

        PreparedStatement pst =
                con.prepareStatement(query);

        ResultSet rs =
                pst.executeQuery();

        while(rs.next()){

%>

<tr>

    <td>
        <%= rs.getInt("booking_id") %>
    </td>

    <td>
        <%= rs.getInt("customer_id") %>
    </td>

    <td>
        <%= rs.getInt("car_id") %>
    </td>

    <td>
        <%= rs.getString("status") %>
    </td>

    <td>

        &#8377;
        <%= rs.getDouble("total_amount") %>

    </td>

    <td>
        <%= rs.getTimestamp("booked_at") %>
    </td>

</tr>

<%

        }

    } catch(Exception e){

        out.println(e);
    }

%>

</table>

</div>

</div>

</body>
</html>