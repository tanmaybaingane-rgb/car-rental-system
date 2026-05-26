<%@ page import="java.sql.*" %>
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

<title>Add Car</title>

<link rel="stylesheet" href="css/style.css">

<style>

    .page-layout{

        display:grid;

        grid-template-columns:1fr 1fr;

        gap:40px;

        align-items:center;

        min-height:80vh;
    }

    .left-panel{

        background:linear-gradient(
                135deg,
                #1e3a8a,
                #2563eb
        );

        color:white;

        padding:50px;

        border-radius:24px;

        box-shadow:0px 10px 25px rgba(0,0,0,0.15);
    }

    .left-panel h1{

        color:white;

        font-size:44px;

        margin-bottom:20px;
    }

    .left-panel p{

        font-size:18px;

        line-height:1.8;

        opacity:0.95;
    }

    .right-panel{

        background:white;

        padding:45px;

        border-radius:24px;

        box-shadow:0px 10px 25px rgba(0,0,0,0.08);
    }

    .right-panel h2{

        margin-bottom:30px;

        font-size:34px;
    }

    .submit-btn{

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

    .submit-btn:hover{

        background:#1d4ed8;

        transform:translateY(-2px);
    }

    .form-row{

        display:grid;

        grid-template-columns:1fr 1fr;

        gap:20px;
    }

</style>

</head>

<body>

<div class="container">

<div class="page-layout">

<div class="left-panel">

    <h1>

        Add New Car

    </h1>

    <p>

        Expand your rental inventory by
        adding new vehicles with pricing,
        fuel type, category and registration
        details into the system.

    </p>

</div>

<div class="right-panel">

    <h2>

        Vehicle Information

    </h2>

<form action="addcar" method="post">

    <label>Car Model</label>

    <input
            type="text"
            name="car_model"
            placeholder="Enter car model"
            required>

<div class="form-row">

<div>

    <label>Category</label>

    <input
            type="text"
            name="category"
            placeholder="SUV / Sedan / Hatchback"
            required>

</div>

<div>

    <label>Fuel Type</label>

    <input
            type="text"
            name="fuel_type"
            placeholder="Petrol / Diesel / EV"
            required>

</div>

</div>

<div class="form-row">

<div>

    <label>Daily Rate</label>

    <input
            type="number"
            step="0.01"
            name="daily_rate"
            placeholder="Enter daily rate"
            required>

</div>

<div>

    <label>Seats</label>

    <input
            type="number"
            name="seats"
            placeholder="Enter seating capacity"
            required>

</div>

</div>

    <label>Registration Number</label>

    <input
            type="text"
            name="registration_no"
            placeholder="Enter registration number"
            required>

    <button
            type="submit"
            class="submit-btn">

        Add Car

    </button>

</form>

</div>

</div>

</div>

</body>
</html>