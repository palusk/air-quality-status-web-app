<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="com.ziecinaplaneta.air.controler.API" %>
<%@ page import="com.ziecinaplaneta.air.data.AirInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ziecinaplaneta.air.controler.Date" %>
<%@ page import="com.ziecinaplaneta.air.data.Filtr" %>
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
  <ul id="textMenu">
    <li> <a  href="index.jsp">Wróć do strony głównej</a></li>
    <li><a href="historical_data.jsp">Dane historyczne</a></li>
    <li><a href="filterData.jsp">Filtruj</a></li>
  </ul>
  </br>

</header>

<div id="historical-data2">
  <form action="admin" method="post">
    <label for="minTemp">Minimalna temperatura:</label>
    <input type="number" step="1" id="minTemp" name="minTemp" value="<%= Filtr.isMinTempAssigned() ? Filtr.getMinTemp() : "" %>">

    <label for="maxTemp">Maksymalna temperatura:</label>
    <input type="number" step="1" id="maxTemp" name="maxTemp" value="<%= Filtr.isMaxTempAssigned() ? Filtr.getMaxTemp() : "" %>">

    <label for="minAQI">Minimalny AQI:</label>
    <input type="number" step="1" id="minAQI" name="minAQI" value="<%= Filtr.isMinAqiAssigned() ? Filtr.getMinAqi() : "" %>">

    <label for="maxAQI">Maksymalny AQI:</label>
    <input type="number" step="1" id="maxAQI" name="maxAQI" value="<%= Filtr.isMaxAqiAssigned() ? Filtr.getMaxAqi() : "" %>">

    <label for="minHum">Minimalna wilgotność:</label>
    <input type="number" step="1" id="minHum" name="minHum" value="<%= Filtr.isMinHumAssigned() ? Filtr.getMinHum() : "" %>">

    <label for="maxHum">Maksymalna wilgotność:</label>
    <input type="number" step="1" id="maxHum" name="maxHum" value="<%= Filtr.isMaxHumAssigned() ? Filtr.getMaxHum() : "" %>">

    <button class="btn" type="submit" name="filtruj" value="filtruj">Filtruj</button>
    <button class="btn" type="submit" name="reset" value="reset">Reset</button>
  </form>

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
    <%
      List<AirInfo> airInfo = database.getAirFilteredAirData();
      boolean dataExist = false;
      for (AirInfo info : airInfo) {%>

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
    <% if(!dataExist){ %>
    <p>Brak danych dla danego filtra</p>
    <% } %>
  </table>
</div>
</body>
</html>
