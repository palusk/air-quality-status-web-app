<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ziecinaplaneta.air.data.AirInfo" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  Driver database = new Driver();
%>
<!DOCTYPE html>
<html>
<head>
  <title>Konto</title>
  <link rel="stylesheet" type="text/css" href="index_style.css">
  <link rel="stylesheet" type="text/css" href="konto_style.css">
</head>
<header class="header">
  <a href="index.jsp"><img id="logobig" src="img/logo.png" alt="logo"></a>
  <ul id="textMenu">
    <li><a href="admin.jsp">ADMINISTRATION</a></li>
    <li><a href="data.jsp">AIR DATA</a></li>
  </ul>
</header>
<body>
<div class="container">
  <div class="user-info">
    <h1>Lista użytkowników</h1>
    <form action="admin" method="post">
      <table id="airDataTable">
        <tr>
          <th>ID History</th>
          <th>Latitude</th>
          <th>Longitude</th>
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
          for (AirInfo info : airInfo) { %>
        <tr>
          <td><input type="text" name="idHistory<%= info.getIdHistory() %>"
                     value="<%= info.getIdHistory() %>"></td>
          <td><input type="text" name="latitude<%= info.getIdHistory() %>"
                     value="<%= info.getLatitude() %>"></td>
          <td><input type="text" name="longitude<%= info.getIdHistory() %>"
                     value="<%= info.getLongitude() %>"></td>
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
          <td>
            <button class="btn" type="submit" name="deleteData" value="<%= info.getIdHistory() %>">usun</button>
          </td>
          <td>
            <button class="btn" type="submit" name="changeData" value="<%= info.getIdHistory() %>">
              Zmień dane
            </button>
          </td>
        </tr>
        <% } %>
      </table>
    </form>
    <form action="admin" method="post">
    <tr>
      <td><input type="text" name="latitude" value="Latitude"></td>
      <td><input type="text" name="longitude" value="Longitude"></td>
      <td><input type="text" name="city" value="City"></td>
      <td><input type="text" name="state" value="State"></td>
      <td><input type="text" name="country" value="Country"></td>
      <td><input type="text" name="temperature" value="Temperature (Celsius)"></td>
      <td><input type="text" name="humidity" value="Humidity (%)"></td>
      <td><input type="text" name="airQuality" value="Air Quality (AQI)"></td>
      <td><input type="text" name="date" value="Date"></td>
      <button class="btn" type="submit" name="addData" value="addData">
        dodaj dane
      </button>
    </tr>
    </form>
  </div>
</div>
</body>
</html>