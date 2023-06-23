<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="com.ziecinaplaneta.air.controler.API" %>
<%@ page import="com.ziecinaplaneta.air.data.AirInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ziecinaplaneta.air.controler.Date" %>
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
    int regionID = database.selectRegionIdFromUsers(iduser);

    String latitude = database.selectLatitude(regionID);
    String longitude = database.selectLongitude(regionID);

    user.setIdRegion(regionID);

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="historical_style.css">
    <title>Zalecenia</title>
</head>
<body>
<div id="bg3"></div>
<header class="header">
    <br id="textMenu2">
    <li> <a  href="index.jsp">Wróć do strony głównej</a></li></br>
</header>

<div id="historical-data">
    <table id="airDataTable">
        <tr>
            <th>City</th>
            <th>State</th>
            <th>Country</th>
            <th>Temperature (Celsius)</th>
            <th>Humidity (%)</th>
            <th>Air Quality (AQI)</th>
            <th>Date</th>
            <th></th>
            <th></th>
        </tr>
        <% List<AirInfo> airInfo = database.getAirDataDatabase();
            boolean dataExist = false;
         for (AirInfo info : airInfo) {
         dataExist = false;
         if (info.getDate().equals(Date.getDate())) {%>
        <tr>
            <td><input type="text" name="city<%= info.getIdHistory() %>" value="<%= info.getCity() %>"></td>
            <td><input type="text" name="state<%= info.getIdHistory() %>" value="<%= info.getState() %>"></td>
            <td><input type="text" name="country<%= info.getIdHistory() %>" value="<%= info.getCountry() %>"></td>
            <td><input type="text" name="temperatureCelsius<%= info.getIdHistory() %>"
                       value="<%= info.getTemperatureCelsius() %>"></td>
            <td><input type="text" name="humidityPercent<%= info.getIdHistory() %>"
                       value="<%= info.getHumidityPercent() %>"></td>
            <td><input type="text" name="airQualityAQI<%= info.getIdHistory() %>"
                       value="<%= info.getAirQualityAQI() %>"></td>
            <td><input type="text" name="date<%= info.getIdHistory() %>" value="<%= info.getDate() %>"></td>
        </tr>
        <% dataExist = true; %>
        <% } %>
        <% } %>
        <% if(!dataExist){ %>
        <p>Brak danych z dnia <%= Date.getDate() %> </p>
        <% } %>
    </table>
    <form action="admin" method="post">
        <button class="btn" type="submit" name="newerData" value="newerData">nowsze data</button>
        <button class="btn" type="submit" name="olderData" value="olderData">starsze dane</button>
    </form>
</div>


</body>
</html>
