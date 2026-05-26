<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <title>Car Rental Service</title>

    <style>

        body{
            margin:0;
            padding:0;
            font-family: Arial, Helvetica, sans-serif;
            background-color:#f4f4f4;
        }

        .navbar{
            background:#111827;
            padding:15px;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .logo{
            color:white;
            font-size:28px;
            font-weight:bold;
        }

        .nav-links a{
            color:white;
            text-decoration:none;
            margin-left:20px;
            font-size:18px;
        }

        .hero{
            height:85vh;
            display:flex;
            flex-direction:column;
            justify-content:center;
            align-items:center;
            text-align:center;
            background:linear-gradient(to right,#1f2937,#111827);
            color:white;
        }

        .hero h1{
            font-size:55px;
            margin-bottom:20px;
        }

        .hero p{
            font-size:22px;
            width:70%;
        }

        .btn{
            margin-top:30px;
            padding:15px 30px;
            background:#2563eb;
            color:white;
            border:none;
            border-radius:8px;
            font-size:20px;
            cursor:pointer;
            text-decoration:none;
        }

        .btn:hover{
            background:#1d4ed8;
        }

    </style>
<link rel="stylesheet" href="css/style.css">
</head>

<body>

    <div class="navbar">

        <div class="logo">
            Car Rental Service
        </div>

        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="#">Cars</a>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
        </div>

    </div>

    <div class="hero">

        <h1>Drive Your Dream Car Today</h1>

        <p>
            Easy booking, affordable prices,
            premium cars and hassle-free rental service.
        </p>

        <a href="#" class="btn">
            Explore Cars
        </a>

    </div>

</body>
</html>