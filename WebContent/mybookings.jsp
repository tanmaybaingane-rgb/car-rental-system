<%@ page import="java.sql.*" %>
<%@ page import="in.car.dbcon.DbConnection" %>
<%@ include file="navbar.jsp" %>

<%
    if(session.getAttribute("customerName") == null){

        response.sendRedirect("login.jsp");
        return;
    }

    int customerId =
            Integer.parseInt(
                    session.getAttribute("customerId").toString()
            );
%>

<!DOCTYPE html>
<html>

<head>

<title>My Bookings</title>

<link rel="stylesheet" href="css/style.css">

<style>

    .page-header{

        margin-bottom:30px;
    }

    .page-header h1{

        font-size:38px;

        margin-bottom:10px;
    }

    .page-header p{

        color:#6b7280;

        font-size:17px;
    }

    .booking-grid{

        display:grid;

        grid-template-columns:
                repeat(auto-fit,minmax(360px,1fr));

        gap:25px;
    }

    .booking-card{

        background:white;

        border-radius:20px;

        padding:30px;

        box-shadow:0px 8px 20px rgba(0,0,0,0.08);

        transition:0.3s;
    }

    .booking-card:hover{

        transform:translateY(-6px);

        box-shadow:0px 12px 25px rgba(0,0,0,0.12);
    }

    .booking-title{

        display:flex;

        justify-content:space-between;

        align-items:center;

        margin-bottom:20px;
    }

    .booking-title h2{

        font-size:28px;
    }

    .badge{

        padding:8px 14px;

        border-radius:30px;

        color:white;

        font-size:13px;

        font-weight:bold;
    }

    .active{

        background:#16a34a;
    }

    .completed{

        background:#2563eb;
    }

    .cancelled{

        background:#dc2626;
    }

    .details{

        margin-bottom:20px;
    }

    .details p{

        margin-bottom:12px;

        color:#374151;

        font-size:15px;
    }

    .amount{

        font-size:30px;

        font-weight:bold;

        color:#2563eb;

        margin-bottom:25px;
    }

    .return-btn{

        width:100%;

        padding:14px;

        border:none;

        border-radius:10px;

        background:#dc2626;

        color:white;

        font-size:16px;

        cursor:pointer;

        transition:0.3s;
    }

    .return-btn:hover{

        background:#b91c1c;

        transform:translateY(-2px);
    }

    .completed-box{

        background:#dcfce7;

        color:#166534;

        padding:14px;

        border-radius:10px;

        text-align:center;

        font-weight:bold;
    }

    .empty-box{

        background:white;

        padding:60px;

        text-align:center;

        border-radius:20px;

        box-shadow:0px 8px 20px rgba(0,0,0,0.08);
    }

    .empty-box h2{

        margin-bottom:15px;
    }

</style>

</head>

<body>

<div class="container">

<div class="page-header">

    <h1>

        My Bookings

    </h1>

    <p>

        Track your active rentals, completed bookings and payment details.

    </p>

</div>

<div class="booking-grid">

<%

    boolean hasBookings = false;

    try{

        Connection con =
                DbConnection.getConnection();

        String query =
                "SELECT b.*, c.car_model " +
                "FROM booking b " +
                "JOIN car c ON b.car_id = c.car_id " +
                "WHERE customer_id=? " +
                "ORDER BY booking_id DESC";

        PreparedStatement pst =
                con.prepareStatement(query);

        pst.setInt(1,customerId);

        ResultSet rs =
                pst.executeQuery();

        while(rs.next()){

            hasBookings = true;

            String status =
                    rs.getString("status");

            String badgeClass = "";

            if(status.equals("Active")){

                badgeClass = "active";

            } else if(status.equals("Completed")){

                badgeClass = "completed";

            } else{

                badgeClass = "cancelled";
            }

%>

<div class="booking-card">

<div class="booking-title">

    <h2>

        <%= rs.getString("car_model") %>

    </h2>

    <span class="badge <%= badgeClass %>">

        <%= status %>

    </span>

</div>

<div class="details">

    <p>

        <strong>Booking ID:</strong>
        <%= rs.getInt("booking_id") %>

    </p>

    <p>

        <strong>Pickup Date:</strong>
        <%= rs.getDate("pickup_date") %>

    </p>

    <p>

        <strong>Return Date:</strong>
        <%= rs.getDate("return_date") %>

    </p>

<%

    if(rs.getDate("actual_return_date") != null){

%>

    <p>

        <strong>Actual Return:</strong>
        <%= rs.getDate("actual_return_date") %>

    </p>

<%

    }

%>

</div>

<div class="amount">

    &#8377;
    <%= rs.getDouble("total_amount") %>

</div>

<%

    if(status.equals("Active")){

%>

<form action="returncar" method="post">

    <input
            type="hidden"
            name="booking_id"
            value="<%= rs.getInt("booking_id") %>">

    <input
            type="hidden"
            name="car_id"
            value="<%= rs.getInt("car_id") %>">

    <button
            type="submit"
            class="return-btn">

        Return Car

    </button>

</form>

<%

    } else{

%>

<div class="completed-box">

    Booking Completed

</div>

<%

    }

%>

</div>

<%

        }

        if(!hasBookings){

%>

<div class="empty-box">

    <h2>

        No Bookings Found

    </h2>

    <p>

        You have not booked any cars yet.

    </p>

</div>

<%

        }

    } catch(Exception e){

        out.println(e);
    }

%>

</div>

</div>

</body>
</html>