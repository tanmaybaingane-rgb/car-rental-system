<%@ include file="navbar.jsp" %>

<%
    String customerName =
            (String) session.getAttribute("customerName");

    if(customerName == null){

        response.sendRedirect("login.jsp");
        return;
    }

    int bookingId =
            Integer.parseInt(
                    request.getParameter("booking_id")
            );
%>

<!DOCTYPE html>
<html>

<head>

    <title>Return Car</title>

    <style>

        body{
            margin:0;
            padding:20px;
            font-family:Arial;
            background:#f3f4f6;
        }

        .container{
            width:450px;
            margin:auto;
            margin-top:100px;
            background:white;
            padding:30px;
            border-radius:10px;
            box-shadow:0px 0px 10px rgba(0,0,0,0.2);
            text-align:center;
        }

        h1{
            color:#111827;
        }

        .btn{
            padding:12px 20px;
            background:#dc2626;
            color:white;
            border:none;
            border-radius:5px;
            cursor:pointer;
            font-size:16px;
        }

        .btn:hover{
            background:#b91c1c;
        }

    </style>
<link rel="stylesheet" href="css/style.css">
</head>

<body style="margin:0; background:#f3f4f6;">

<div class="container" style="margin-top:40px;">

    <h1>Return Car</h1>

    <p>
        Are you sure you want to return this car?
    </p>

    <form action="returncar" method="post">

        <input type="hidden"
               name="booking_id"
               value="<%= bookingId %>">

        <br><br>

<label>
    Any Damage / Issue:
</label>

<br><br>

<textarea
    name="description"
    rows="4"
    style="
        width:100%;
        padding:10px;
        border:1px solid #ccc;
        border-radius:5px;
    "
></textarea>

<br><br>

<label>
    Maintenance Cost:
</label>

<br><br>

<input
    type="number"
    step="0.01"
    name="cost"
    value="0"
    style="
        width:100%;
        padding:10px;
        border:1px solid #ccc;
        border-radius:5px;
    "
>

<br><br>

<label>

    <input
        type="checkbox"
        name="maintenance_required"
        value="yes"
    >

    Send Car For Maintenance

</label>

<br><br>

        <button type="submit"
                class="btn">

            Confirm Return

        </button>

    </form>

</div>

</body>
</html>