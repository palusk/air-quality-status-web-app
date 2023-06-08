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
  <a  href="index.jsp"><img id="logobig" src="img/logo.png" alt="logo"></a>
  <ul id="textMenu">
    <li> <a  href="admin.jsp">ADMINISTRATION</a></li>
    <li> <a  href="data.jsp">AIR DATA</a></li>
  </ul>
</header>
<body><div class="container">
  <div class="user-info">
    <h1>Lista użytkowników</h1>
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
      </tr>
      <%
        List<AirInfo> airInfo = database.getAirDataDatabase();
        for (AirInfo info : airInfo) {
      %>
      <tr>
        <td><%= info.getIdHistory() %></td>
        <td><%= info.getLatitude() %></td>
        <td><%= info.getLongitude() %></td>
        <td><%= info.getCity() %></td>
        <td><%= info.getState() %></td>
        <td><%= info.getCountry() %></td>
        <td><%= info.getTemperatureCelsius() %></td>
        <td><%= info.getHumidityPercent() %></td>
        <td><%= info.getAirQualityAQI() %></td>
        <td><%= info.getDate() %></td>
        <td><form action="admin" method="post">
          <button class="btn" type="submit" name="deleteUser" value="<%= info.getIdHistory() %>">usun</button></form>
        </td>
        <td>
          <select name="permissionsDropdown_<%= info.getIdHistory() %>">
            <option value="-1">-1</option>
            <option value="0">0</option>
            <option value="1">1</option>
          </select>
          <button class="btn" type="submit" name="changePermission" value="<%= info.getIdHistory() %>">Zmień uprawnienia</button>
          </form>
        </td>
      </tr>
      <% } %>
    </table>
    </form>
  </div>
</div>
</body>
</html>