<%@ page import="java.sql.*" %>
<%@ page import="in.car.dbcon.DbConnection" %>
<%@ include file="navbar.jsp" %>

<%
    if(session.getAttribute("customerName") == null){

        response.sendRedirect("login.jsp");
        return;
    }

    int carId =
            Integer.parseInt(
                    request.getParameter("car_id")
            );

    String carModel = "";
    double dailyRate = 0;

    try{

        Connection con =
                DbConnection.getConnection();

        String query =
                "SELECT * FROM car WHERE car_id=?";

        PreparedStatement pst =
                con.prepareStatement(query);

        pst.setInt(1,carId);

        ResultSet rs =
                pst.executeQuery();

        if(rs.next()){

            carModel =
                    rs.getString("car_model");

            dailyRate =
                    rs.getDouble("daily_rate");
        }

    } catch(Exception e){

        out.println(e);
    }
%>

<!DOCTYPE html>
<html>

<head>

<title>Book Car</title>

<link rel="stylesheet" href="css/style.css">

<style>

    .booking-layout{

        display:grid;

        grid-template-columns:1fr 1fr;

        gap:40px;

        align-items:center;

        min-height:80vh;
    }

    .car-preview{

        background:linear-gradient(
                135deg,
                #1e3a8a,
                #2563eb
        );

        color:white;

        border-radius:24px;

        overflow:hidden;

        box-shadow:0px 10px 25px rgba(0,0,0,0.15);
    }

    .car-image{

        height:300px;

        background-image:url(
        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=2070'
        );

        background-size:cover;

        background-position:center;
    }

    .car-info{

        padding:35px;
    }

    .car-info h1{

        color:white;

        font-size:40px;

        margin-bottom:15px;
    }

    .car-info p{

        font-size:18px;

        opacity:0.95;

        margin-bottom:15px;
    }

    .price{

        font-size:36px;

        font-weight:bold;

        margin-top:20px;
    }

    .booking-form{

        background:white;

        padding:45px;

        border-radius:24px;

        box-shadow:0px 10px 25px rgba(0,0,0,0.08);
    }

    .booking-form h2{

        font-size:34px;

        margin-bottom:30px;
    }

    .book-btn{

        width:100%;

        padding:15px;

        border:none;

        border-radius:10px;

        background:#2563eb;

        color:white;

        font-size:16px;

        cursor:pointer;

        transition:0.3s;
    }

    .book-btn:hover{

        background:#1d4ed8;

        transform:translateY(-2px);
    }

</style>

</head>

<body>

<div class="container">

<div class="booking-layout">

<div class="car-preview">

<div class="car-image"></div>

<div class="car-info">

    <h1>

        <%= carModel %>

    </h1>

    <p>

        Premium rental vehicle available
        for your next journey.

    </p>

    <div class="price">

        &#8377;
        <%= dailyRate %>
        / day

    </div>

</div>

</div>

<div class="booking-form">

    <h2>

        Confirm Booking

    </h2>

<form action="bookcar" method="post">

    <input
            type="hidden"
            name="car_id"
            value="<%= carId %>">

    <label>Pickup Date</label>

    <input
            type="date"
            name="pickup_date"
            required>

    <label>Return Date</label>

    <input
            type="date"
            name="return_date"
            required>

    <button
            type="submit"
            class="book-btn">

        Confirm Booking

    </button>

</form>

</div>

</div>

</div>

</body>
</html>