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

    <title>Dashboard</title>

    <link rel="stylesheet" href="css/style.css">

    <style>

        .welcome-box{

            background:linear-gradient(
                    135deg,
                    #1e3a8a,
                    #2563eb
            );

            color:white;

            padding:35px;

            border-radius:18px;

            margin-bottom:30px;

            box-shadow:0px 8px 20px rgba(0,0,0,0.15);
        }

        .welcome-box h1{

            color:white;

            margin-bottom:10px;

            font-size:38px;
        }

        .welcome-box p{

            opacity:0.9;

            font-size:18px;
        }

        .dashboard-grid{

            display:grid;

            grid-template-columns:
                    repeat(auto-fit,minmax(240px,1fr));

            gap:25px;

            margin-bottom:40px;
        }

        .dashboard-card{

            padding:30px;

            border-radius:18px;

            color:white;

            box-shadow:0px 8px 20px rgba(0,0,0,0.12);

            transition:0.3s;
        }

        .dashboard-card:hover{

            transform:translateY(-6px);
        }

        .dashboard-card h1{

            color:white;

            font-size:42px;

            margin-bottom:12px;
        }

        .dashboard-card p{

            font-size:17px;

            opacity:0.95;
        }

        .recent-title{

            margin-top:20px;

            margin-bottom:20px;

            font-size:28px;
        }

    </style>

</head>

<body>

<div class="container">

<div class="welcome-box">

    <h1>

        Welcome,
        <%= session.getAttribute("customerName") %>

    </h1>

    <p>

        Manage bookings, cars, maintenance and business analytics efficiently.

    </p>

</div>

<div class="dashboard-grid">

<%

    try{

        Connection con =
                DbConnection.getConnection();

        Statement st =
                con.createStatement();

        ResultSet rs1 =
                st.executeQuery(
                        "SELECT COUNT(*) FROM car"
                );

        rs1.next();

        int totalCars =
                rs1.getInt(1);

        ResultSet rs2 =
                st.executeQuery(
                        "SELECT COUNT(*) FROM car WHERE status='Available'"
                );

        rs2.next();

        int availableCars =
                rs2.getInt(1);

        ResultSet rs3 =
                st.executeQuery(
                        "SELECT COUNT(*) FROM booking WHERE status='Active'"
                );

        rs3.next();

        int activeBookings =
                rs3.getInt(1);

        ResultSet rs4 =
                st.executeQuery(
                        "SELECT COUNT(*) FROM car WHERE status='Maintenance'"
                );

        rs4.next();

        int maintenanceCars =
                rs4.getInt(1);

        ResultSet rs5 =
                st.executeQuery(
                        "SELECT IFNULL(SUM(total_amount),0) FROM booking"
                );

        rs5.next();

        double totalRevenue =
                rs5.getDouble(1);

        ResultSet rs6 =
                st.executeQuery(
                        "SELECT IFNULL(SUM(cost),0) FROM maintenance WHERE resolved=0"
                );

        rs6.next();

        double pendingMaintenanceCost =
                rs6.getDouble(1);

%>

<div class="dashboard-card"
     style="
        background:linear-gradient(135deg,#2563eb,#1d4ed8);
     ">

    <h1>
        <%= totalCars %>
    </h1>

    <p>Total Cars</p>

</div>

<div class="dashboard-card"
     style="
        background:linear-gradient(135deg,#16a34a,#15803d);
     ">

    <h1>
        <%= availableCars %>
    </h1>

    <p>Available Cars</p>

</div>

<div class="dashboard-card"
     style="
        background:linear-gradient(135deg,#ea580c,#c2410c);
     ">

    <h1>
        <%= activeBookings %>
    </h1>

    <p>Active Bookings</p>

</div>

<div class="dashboard-card"
     style="
        background:linear-gradient(135deg,#dc2626,#b91c1c);
     ">

    <h1>
        <%= maintenanceCars %>
    </h1>

    <p>Cars In Maintenance</p>

</div>

<div class="dashboard-card"
     style="
        background:linear-gradient(135deg,#7c3aed,#6d28d9);
     ">

    <h1>

        &#8377;
        <%= totalRevenue %>

    </h1>

    <p>Total Revenue</p>

</div>

<div class="dashboard-card"
     style="
        background:linear-gradient(135deg,#be123c,#9f1239);
     ">

    <h1>

        &#8377;
        <%= pendingMaintenanceCost %>

    </h1>

    <p>Pending Maintenance Cost</p>

</div>

<%

    } catch(Exception e){

        out.println(e);
    }

%>

</div>

<h2 class="recent-title">

    Recent Bookings

</h2>

<table>

<tr>

    <th>Booking ID</th>

    <th>Customer ID</th>

    <th>Car ID</th>

    <th>Pickup Date</th>

    <th>Return Date</th>

    <th>Status</th>

    <th>Amount</th>

</tr>

<%

    try{

        Connection con =
                DbConnection.getConnection();

        String recentQuery =
                "SELECT * FROM booking " +
                "ORDER BY booking_id DESC LIMIT 5";

        PreparedStatement pst =
                con.prepareStatement(recentQuery);

        ResultSet recentRs =
                pst.executeQuery();

        while(recentRs.next()){

%>

<tr>

    <td>
        <%= recentRs.getInt("booking_id") %>
    </td>

    <td>
        <%= recentRs.getInt("customer_id") %>
    </td>

    <td>
        <%= recentRs.getInt("car_id") %>
    </td>

    <td>
        <%= recentRs.getDate("pickup_date") %>
    </td>

    <td>
        <%= recentRs.getDate("return_date") %>
    </td>

    <td>
        <%= recentRs.getString("status") %>
    </td>

    <td>

        &#8377;
        <%= recentRs.getDouble("total_amount") %>

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

</body>
</html>