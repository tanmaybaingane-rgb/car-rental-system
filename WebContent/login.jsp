<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Login</title>

<link rel="stylesheet" href="css/style.css">

<style>

    body{

        height:100vh;

        display:flex;

        justify-content:center;

        align-items:center;

        background:
                linear-gradient(
                        135deg,
                        rgba(30,58,138,0.9),
                        rgba(37,99,235,0.9)
                ),

                url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=2070');

        background-size:cover;

        background-position:center;
    }

    .login-container{

        width:900px;

        display:grid;

        grid-template-columns:1fr 1fr;

        background:rgba(255,255,255,0.12);

        backdrop-filter:blur(14px);

        border-radius:24px;

        overflow:hidden;

        box-shadow:0px 10px 40px rgba(0,0,0,0.25);
    }

    .left-panel{

        padding:60px;

        color:white;

        display:flex;

        flex-direction:column;

        justify-content:center;
    }

    .left-panel h1{

        color:white;

        font-size:42px;

        margin-bottom:20px;
    }

    .left-panel p{

        font-size:18px;

        line-height:1.7;

        opacity:0.95;
    }

    .right-panel{

        background:white;

        padding:60px;
    }

    .right-panel h2{

        margin-bottom:30px;

        font-size:32px;
    }

    .login-btn{

        width:100%;

        padding:14px;

        border:none;

        border-radius:10px;

        background:#2563eb;

        color:white;

        font-size:16px;

        cursor:pointer;

        transition:0.3s;
    }

    .login-btn:hover{

        background:#1d4ed8;

        transform:translateY(-2px);
    }

    .register-link{

        margin-top:20px;

        text-align:center;
    }

    .register-link a{

        color:#2563eb;

        text-decoration:none;

        font-weight:bold;
    }

    .register-link a:hover{

        text-decoration:underline;
    }

</style>

</head>

<body>

<div class="login-container">

<div class="left-panel">

    <h1>

        Car Rental System

    </h1>

    <p>

        Manage bookings, rentals, maintenance,
        analytics and business operations
        through a modern car rental platform.

    </p>

</div>

<div class="right-panel">

    <h2>

        Login

    </h2>

<form action="login" method="post">

    <label>Email</label>

    <input
            type="email"
            name="email"
            placeholder="Enter your email"
            required>

    <label>Password</label>

    <input
            type="password"
            name="password"
            placeholder="Enter your password"
            required>

    <button
            type="submit"
            class="login-btn">

        Login

    </button>

</form>

<div class="register-link">

    Don’t have an account?

    <a href="register.jsp">

        Register

    </a>

</div>

</div>

</div>

</body>
</html>