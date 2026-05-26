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

<title>Cars</title>

<link rel="stylesheet" href="css/style.css">

<style>

    .top-section{

        display:flex;

        justify-content:space-between;

        align-items:center;

        margin-bottom:30px;

        flex-wrap:wrap;

        gap:20px;
    }

    .top-section h1{

        font-size:36px;
    }

    .search-box{

        width:320px;
    }

    .search-box input{

        margin:0;
    }

    .cars-grid{

        display:grid;

        grid-template-columns:
                repeat(auto-fit,minmax(320px,1fr));

        gap:25px;
    }

    .car-card{

        background:white;

        border-radius:20px;

        overflow:hidden;

        box-shadow:0px 8px 20px rgba(0,0,0,0.08);

        transition:0.3s;
    }

    .car-card:hover{

        transform:translateY(-6px);

        box-shadow:0px 12px 25px rgba(0,0,0,0.12);
    }

    .car-image{

        height:220px;

        background-size:cover;

        background-position:center;
    }

    .car-content{

        padding:25px;
    }

    .car-title{

        font-size:28px;

        margin-bottom:12px;

        color:#1e3a8a;
    }

    .car-details{

        margin-bottom:20px;
    }

    .car-details p{

        margin-bottom:10px;

        color:#374151;

        font-size:15px;
    }

    .badge{

        display:inline-block;

        padding:8px 14px;

        border-radius:30px;

        color:white;

        font-size:13px;

        font-weight:bold;

        margin-bottom:20px;
    }

    .available{

        background:#16a34a;
    }

    .rented{

        background:#ea580c;
    }

    .maintenance{

        background:#dc2626;
    }

    .price{

        font-size:28px;

        font-weight:bold;

        color:#2563eb;

        margin-bottom:20px;
    }

    .book-btn{

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

    .book-btn:hover{

        background:#1d4ed8;

        transform:translateY(-2px);
    }

    .disabled-btn{

        width:100%;

        padding:14px;

        border:none;

        border-radius:10px;

        background:#9ca3af;

        color:white;

        font-size:16px;
    }

</style>

</head>

<body>

<div class="container">

<div class="top-section">

    <h1>

        Available Cars

    </h1>

<form method="get" class="search-box">

    <input
            type="text"
            name="search"
            placeholder="Search car model or category">

</form>

</div>

<div class="cars-grid">

<%

    try{

        Connection con =
                DbConnection.getConnection();

        String search =
                request.getParameter("search");

        String query;

        if(search != null && !search.trim().equals("")){

            query =
                    "SELECT * FROM car " +
                    "WHERE car_model LIKE ? " +
                    "OR category LIKE ?";

        } else{

            query =
                    "SELECT * FROM car";
        }

        PreparedStatement pst =
                con.prepareStatement(query);

        if(search != null && !search.trim().equals("")){

            pst.setString(1,"%"+search+"%");
            pst.setString(2,"%"+search+"%");
        }

        ResultSet rs =
                pst.executeQuery();

        while(rs.next()){

            String status =
                    rs.getString("status");

            String badgeClass = "";

            if(status.equals("Available")){

                badgeClass = "available";

            } else if(status.equals("Rented")){

                badgeClass = "rented";

            } else{

                badgeClass = "maintenance";
            }

%>

<div class="car-card">

<div class="car-image"
     style="
        background-image:url(
        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=2070'
        );
     ">
</div>

<div class="car-content">

    <div class="car-title">

        <%= rs.getString("car_model") %>

    </div>

    <span class="badge <%= badgeClass %>">

        <%= status %>

    </span>

    <div class="car-details">

        <p>

            <strong>Category:</strong>
            <%= rs.getString("category") %>

        </p>

        <p>

            <strong>Fuel Type:</strong>
            <%= rs.getString("fuel_type") %>

        </p>

        <p>

            <strong>Seats:</strong>
            <%= rs.getInt("seats") %>

        </p>

        <p>

            <strong>Registration:</strong>
            <%= rs.getString("registration_no") %>

        </p>

    </div>

    <div class="price">

        &#8377;
        <%= rs.getDouble("daily_rate") %>
        /day

    </div>

<%

    if(status.equals("Available")){

%>

<form action="bookcar.jsp" method="get">

    <input
            type="hidden"
            name="car_id"
            value="<%= rs.getInt("car_id") %>">

    <button
            type="submit"
            class="book-btn">

        Book Now

    </button>

</form>

<%

    } else{

%>

<button class="disabled-btn">

    Currently Unavailable

</button>

<%

    }

%>

</div>

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