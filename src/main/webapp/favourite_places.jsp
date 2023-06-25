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
    boolean empty = true;

    for (int i = 0; i < 10; i++) {
        if(favouritesIdTAB[i] != 0 ) empty = false;
    }
    AirInfo data;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="favourite_places.css">
    <title>Ulubione miasta</title>
    <style>
        .circle {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            font-size: 14px;
            font-weight: bold;
            margin-right: 10px;
        }

        .green {
            background-color: #66BB6A;
            color: #ffffff;
        }

        .yellow {
            background-color: #FFCA28;
            color: #000000;
        }

        .orange {
            background-color: #FFA726;
            color: #000000;
        }

        .red {
            background-color: #EF5350;
            color: #ffffff;
        }

        #chart-container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: flex;
            justify-content: space-between;
            width: 600px;
        }



        .chart {
            width: 150px;
            margin-right: 20px;
        }



        .bar {
            width: 100%;
            height: 200px;
            background-color: lightgray;
            margin-bottom: 10px;
        }



        .bar-label {
            text-align: center;
            font-weight: bold;
        }

    </style>
</head>
<body>
<div id="bg3"></div>
<header class="header">
    <br id="textMenu2">
    <li><a href="index.jsp">Wróć do strony głównej</a></li><br>
    <% if(empty) { %>
    <li> <a  href="konto.jsp">Aby zobaczyć statystyki dla ulubionych miast, kliknij aby przejść do panelu konta użytkownika i wybierz swoje ulubione miasta.</a></li>
    <% } %>
</header>



<div id="favourite-places">
    <% if(!empty) { %>
    <h2>Statystyki z ulubionych miast:</h2><br>
    <%}%>
    <% for(int x = 0; x<10; x++) {
        if (favouritesIdTAB[x] != 0) {
            data = API.getAirData(database.selectLatitude(favouritesIdTAB[x]), database.selectLongitude(favouritesIdTAB[x]));
            int AQI = data.getAirQualityAQI();
            String colorClass;
            if (AQI <= 49) {
                colorClass = "green";
            } else if (AQI >= 50 && AQI <= 99) {
                colorClass = "yellow";
            } else if (AQI >= 100 && AQI <= 149) {
                colorClass = "orange";
            } else {
                colorClass = "red";
            }
    %>
    <h3><%= database.selectRegionName(favouritesIdTAB[x]) %></h3>
    <div class="circle <%= colorClass %>">
        <p>AQI: <%= AQI %></p>
    </div>
    <p>Wilgotność wynosi <%= data.getHumidityPercent() %>%</p>
    <p>Temperatura wynosi <%= data.getTemperatureCelsius() %>℃</p>
    <% } } %>
</div>


<div id="chart-container">
    <div class="chart">
        <% if(!empty) { %>
        <h3>AQI (jakość powietrza)</h3>
        <%}%>
        <% for (int x = 0; x < 10; x++) {
            if (favouritesIdTAB[x] != 0) {
                String regionName = database.selectRegionName(favouritesIdTAB[x]);
                data = API.getAirData(database.selectLatitude(favouritesIdTAB[x]), database.selectLongitude(favouritesIdTAB[x]));
                int aqiValue = data.getAirQualityAQI();
        %>
        <div class="bar" style="height: <%= aqiValue * 2 %>px; background-color: lemonchiffon"></div>
        <div class="bar-label"><%= regionName %></div>
        <% } } %>
    </div>



    <div class="chart">
        <% if(!empty) { %>
        <h3>Wilgotność</h3>
        <%}%>
        <% for (int x = 0; x < 10; x++) {
            if (favouritesIdTAB[x] != 0) {
                String regionName = database.selectRegionName(favouritesIdTAB[x]);
                data = API.getAirData(database.selectLatitude(favouritesIdTAB[x]), database.selectLongitude(favouritesIdTAB[x]));
                int humidityValue = data.getHumidityPercent();
        %>
        <div class="bar" style="height: <%= humidityValue * 2 %>px;  background-color: lightskyblue"></div>
        <div class="bar-label"><%= regionName %></div>
        <% } } %>
    </div>



    <div class="chart">
        <% if(!empty) { %>
        <h3>Temperatura</h3>
        <%}%>
        <% for (int x = 0; x < 10; x++) {
            if (favouritesIdTAB[x] != 0) {
                String regionName = database.selectRegionName(favouritesIdTAB[x]);
                data = API.getAirData(database.selectLatitude(favouritesIdTAB[x]), database.selectLongitude(favouritesIdTAB[x]));
                double temperatureValue = data.getTemperatureCelsius();
        %>
        <div class="bar" style="height: <%= temperatureValue + 20 %>px;  background-color: lightpink"></div>
        <div class="bar-label"><%= regionName %></div>
        <% } } %>
    </div>
</div>


<div id="favourite-places-average-data">
    <% if(!empty) { %>
    <h2>Średnie statystyki z ulubionych miast:</h2><br>
    <%}%>
<%
    for (int i = 0; i < 10; i++) {%>
<%if(user.favourites.getRegions()[i]==true){%>
<p><%= database.getAverage(i+1)%></p>
<%}%>
<%}%>
</div>


</body>
</html>