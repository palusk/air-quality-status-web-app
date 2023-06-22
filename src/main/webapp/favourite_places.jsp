<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="com.ziecinaplaneta.air.controler.API" %>
<%@ page import="com.ziecinaplaneta.air.data.AirInfo" %>
<%@ page import="com.ziecinaplaneta.air.data.Favourites" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Account user = (Account) session.getAttribute("user");
    if (user == null){
        user = new Account();
        session.setAttribute("user", user);
    }

    String userName = user.getLogin();

    Driver database = new Driver();


    int iduser = database.getUserId(userName);

    int[] favouritesIdTAB = database.getFavouriteRegionsId(iduser);

    AirInfo data;


%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="favourite_places.css">
    <title>Ulubione miasta</title>

    <style>
        .chart {
            width: 200px;
            height: 200px;
            position: relative;
            border-radius: 50%;
            background-color: lightgray;
            overflow: hidden;
        }

        .slice {
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }

        .slice-1 {
            clip-path: polygon(0 0, 100% 0, 100% 50%, 50% 50%);
            background-color: #ff6384;
        }

        .slice-2 {
            clip-path: polygon(50% 0, 100% 0, 100% 100%, 50% 100%);
            background-color: #36a2eb;
        }

        .slice-3 {
            clip-path: polygon(0 50%, 50% 50%, 50% 100%, 0 100%);
            background-color: #ffce56;
        }

        .label {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 16px;
            font-weight: bold;
            color: white;
        }
    </style>

</head>
<body>
<%--<div id="bg3">--%>
<header class="header">
    <br id="textMenu2">
    <li> <a  href="index.jsp">Wróć do strony głównej</a></li></br>
</header>

<div id="favourite-places">
    <h2>Statystyki z ulubionych miast:</h2></br>
    <%for(int x = 0; x<10; x++){
    if(favouritesIdTAB[x] != 0){ %>
        <h3><%=database.selectRegionName(favouritesIdTAB[x]) %></h3>

        <%data = API.getAirData(database.selectLatitude(favouritesIdTAB[x]), database.selectLongitude(favouritesIdTAB[x]));%>

        <p>AQI wynosi <%= data.getAirQualityAQI()%></p>
        <p>Wilgotność wynosi <%= data.getHumidityPercent()%>%</p>
        <p>Temperatura wynosi <%= data.getTemperatureCelsius()%>℃</p></br>
        <%}%>
    <%}%>
    <div class="chart">
        <div class="slice slice-1">
            <span class="label">25%</span>
        </div>
        <div class="slice slice-2">
            <span class="label">35%</span>
        </div>
        <div class="slice slice-3">
            <span class="label">40%</span>
        </div>
    </div>
</div>


<%--</div>--%>



</body>
</html>
