<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if(session.getAttribute("customerName") == null){

        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <title>Rental Agreement</title>

    <style>

        body{
            margin:0;
            font-family:Arial;
            background:#f3f4f6;
        }

        .container{
            max-width:700px;
            margin:40px auto;
            background:white;
            padding:30px;
            border-radius:10px;
            box-shadow:0px 0px 10px rgba(0,0,0,0.2);
        }

        h1{
            text-align:center;
            color:#1e3a8a;
        }

        table{
            width:100%;
            margin-top:20px;
            border-collapse:collapse;
        }

        td{
            padding:12px;
            border-bottom:1px solid #ddd;
        }

        .terms{
            margin-top:25px;
            background:#f9fafb;
            padding:20px;
            border-radius:8px;
            line-height:1.7;
        }

        .btn{
            display:inline-block;
            margin-top:25px;
            padding:12px 20px;
            background:#2563eb;
            color:white;
            text-decoration:none;
            border-radius:5px;
        }

    </style>
<link rel="stylesheet" href="css/style.css">
</head>

<body>

<%@ include file="navbar.jsp" %>

<div class="container">

    <h1>Rental Agreement</h1>

    <table>

        <tr>
            <td><strong>Booking ID</strong></td>
            <td><%= request.getParameter("booking_id") %></td>
        </tr>

        <tr>
            <td><strong>Customer Name</strong></td>
            <td><%= session.getAttribute("customerName") %></td>
        </tr>

        <tr>
            <td><strong>Agreement Date</strong></td>
            <td><%= java.time.LocalDate.now() %></td>
        </tr>

        <tr>
            <td><strong>Security Deposit</strong></td>
            <td>&#8377; 5000</td>
        </tr>

    </table>

    <div class="terms">

        <h3>Terms & Conditions</h3>

        <p>
            1. Customer must return the vehicle on time.
        </p>

        <p>
            2. Any vehicle damage will be charged separately.
        </p>

        <p>
            3. Late return may result in extra charges.
        </p>

        <p>
            4. Customer is responsible for traffic violations during rental period.
        </p>

    </div>

    <a href="dashboard.jsp" class="btn">
        Back to Dashboard
    </a>

</div>

</body>
</html>