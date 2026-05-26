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

<title>Maintenance</title>

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

    .maintenance-grid{

        display:grid;

        grid-template-columns:
                repeat(auto-fit,minmax(380px,1fr));

        gap:25px;
    }

    .maintenance-card{

        background:white;

        border-radius:22px;

        overflow:hidden;

        box-shadow:0px 8px 20px rgba(0,0,0,0.08);

        transition:0.3s;
    }

    .maintenance-card:hover{

        transform:translateY(-6px);

        box-shadow:0px 12px 25px rgba(0,0,0,0.12);
    }

    .card-top{

        background:linear-gradient(
                135deg,
                #dc2626,
                #b91c1c
        );

        color:white;

        padding:25px;
    }

    .card-top h2{

        color:white;

        font-size:30px;

        margin-bottom:10px;
    }

    .status-badge{

        display:inline-block;

        padding:8px 14px;

        border-radius:30px;

        font-size:13px;

        font-weight:bold;

        background:white;

        color:#dc2626;
    }

    .card-body{

        padding:25px;
    }

    .detail-row{

        margin-bottom:14px;

        color:#374151;

        line-height:1.6;
    }

    .cost{

        font-size:30px;

        font-weight:bold;

        color:#dc2626;

        margin-top:20px;

        margin-bottom:25px;
    }

    .resolve-btn{

        width:100%;

        padding:14px;

        border:none;

        border-radius:10px;

        background:#16a34a;

        color:white;

        font-size:16px;

        cursor:pointer;

        transition:0.3s;
    }

    .resolve-btn:hover{

        background:#15803d;

        transform:translateY(-2px);
    }

    .resolved-box{

        background:#dcfce7;

        color:#166534;

        padding:15px;

        border-radius:10px;

        text-align:center;

        font-weight:bold;
    }

    .empty-box{

        background:white;

        padding:60px;

        border-radius:20px;

        text-align:center;

        box-shadow:0px 8px 20px rgba(0,0,0,0.08);
    }

</style>

</head>

<body>

<div class="container">

<div class="page-header">

    <h1>

        Maintenance Management

    </h1>

    <p>

        Track service issues, maintenance expenses and repair status.

    </p>

</div>

<div class="maintenance-grid">

<%

    boolean hasData = false;

    try{

        Connection con =
                DbConnection.getConnection();

        String query =
                "SELECT m.*, c.car_model " +
                "FROM maintenance m " +
                "JOIN car c ON m.car_id = c.car_id " +
                "ORDER BY maintenance_id DESC";

        PreparedStatement pst =
                con.prepareStatement(query);

        ResultSet rs =
                pst.executeQuery();

        while(rs.next()){

            hasData = true;

            boolean resolved =
                    rs.getBoolean("resolved");

%>

<div class="maintenance-card">

<div class="card-top">

    <h2>

        <%= rs.getString("car_model") %>

    </h2>

    <span class="status-badge">

<%

    if(resolved){

%>

        RESOLVED

<%

    } else{

%>

        PENDING

<%

    }

%>

    </span>

</div>

<div class="card-body">

    <div class="detail-row">

        <strong>Maintenance ID:</strong>

        <%= rs.getInt("maintenance_id") %>

    </div>

    <div class="detail-row">

        <strong>Description:</strong>

        <%= rs.getString("description") %>

    </div>

    <div class="detail-row">

        <strong>Date:</strong>

        <%= rs.getDate("maintenance_date") %>

    </div>

    <div class="detail-row">

        <strong>Logged By:</strong>

        <%= rs.getString("logged_by") %>

    </div>

    <div class="cost">

        &#8377;
        <%= rs.getDouble("cost") %>

    </div>

<%

    if(!resolved){

%>

<form action="resolvemaintenance" method="get">

    <input
            type="hidden"
            name="maintenance_id"
            value="<%= rs.getInt("maintenance_id") %>">

    <input
            type="hidden"
            name="car_id"
            value="<%= rs.getInt("car_id") %>">

    <button
            type="submit"
            class="resolve-btn">

        Resolve Maintenance

    </button>

</form>

<%

    } else{

%>

<div class="resolved-box">

    Maintenance Completed

</div>

<%

    }

%>

</div>

</div>

<%

        }

        if(!hasData){

%>

<div class="empty-box">

    <h2>

        No Maintenance Records

    </h2>

    <p>

        No maintenance issues have been logged yet.

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