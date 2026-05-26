<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Register</title>

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

                url('https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?q=80&w=2083');

        background-size:cover;

        background-position:center;
    }

    .register-container{

        width:950px;

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

        padding:50px;
    }

    .right-panel h2{

        margin-bottom:25px;

        font-size:32px;
    }

    .register-btn{

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

    .register-btn:hover{

        background:#1d4ed8;

        transform:translateY(-2px);
    }

    .login-link{

        margin-top:20px;

        text-align:center;
    }

    .login-link a{

        color:#2563eb;

        text-decoration:none;

        font-weight:bold;
    }

    .login-link a:hover{

        text-decoration:underline;
    }

</style>

</head>

<body>

<div class="register-container">

<div class="left-panel">

    <h1>

        Create Account

    </h1>

    <p>

        Register to access the complete
        car rental management platform
        with bookings, reports, analytics
        and maintenance workflows.

    </p>

</div>

<div class="right-panel">

    <h2>

        Register

    </h2>

<form action="register" method="post">

    <label>Full Name</label>

    <input
            type="text"
            name="name"
            placeholder="Enter full name"
            required>

    <label>Email</label>

    <input
            type="email"
            name="email"
            placeholder="Enter email"
            required>

    <label>Password</label>

    <input
            type="password"
            name="password"
            placeholder="Create password"
            required>

    <label>Phone</label>

    <input
            type="text"
            name="phone"
            placeholder="Enter phone number"
            required>

    <button
            type="submit"
            class="register-btn">

        Register

    </button>

</form>

<div class="login-link">

    Already have an account?

    <a href="login.jsp">

        Login

    </a>

</div>

</div>

</div>

</body>
</html>