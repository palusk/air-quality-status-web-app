<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ziecinaplaneta.air.data.AirInfo" %>
<%@ page import="com.ziecinaplaneta.air.data.RegionsInfo" %>
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
      <button class="btn" type="submit" name="addData" value="addData">dodaj dane</button>
    </tr>
    </form>



    <form id="region-form" action="admin" method="post">

      <input type="hidden" id="lat-input" name="latR">
      <input type="hidden" id="lon-input" name="lonR">

      <input type="hidden" id="city-input" name="cityR">
      <input type="hidden" id="state-input" name="stateR">
      <input type="hidden" id="country-input" name="countryR">
      <input type="hidden" id="temperature-input" name="temperatureR">
      <input type="hidden" id="humidity-input" name="humidityR">
      <input type="hidden" id="airQuality-input" name="airQualityR">
      <button class="btn" type="submit" name="regionUpdateData" value="regionUpdateData">Zaktualizuj dane dla każdego regionu</button>
    </form>

      <script>

         // Funkcja obsługująca formularz
         $('#region-form').submit(function(event) {
           event.preventDefault();

           <% List<RegionsInfo> regionsInfo = database.getRegionsDatabase();
                  for (RegionsInfo region : regionsInfo) { %>

           <% String latitude = region.getLatitude();
            String longitude = region.getLongitude(); %>

           var lat = '<%=latitude%>';
          var lon = '<%=longitude%>';


// Pobranie danych pogodowych z API
          var apiKey = '64052ff3-73e2-4bab-9592-06e204bf2df2'; // klucz API
          var apiUrl = 'https://api.airvisual.com/v2/nearest_city?lat=' + lat + '&lon=' + lon + '&key=' + apiKey;

          $.ajax({
            url: apiUrl,
            type: 'GET',
            success: function(data) {
// Wyświetlenie danych na stronie
              var city = data.data.city;
              var state = data.data.state;
              var country = data.data.country;
              var temperature = data.data.current.weather.tp;
              var humidity = data.data.current.weather.hu;
              var airQuality= data.data.current.pollution.aqius;

              $('#lat-input').val(lat);
              $('#lon-input').val(lon);
              $('#city-input').val(city);
              $('#state-input').val(state);
              $('#country-input').val(country);
              $('#temperature-input').val(temperature);
              $('#humidity-input').val(humidity);
              $('#airQuality-input').val(airQuality);

              // var weatherData = 'Miasto: ' + city + '<br>' +
              //         'Stan: ' + state + '<br>' +
              //         'Kraj: ' + country + '<br>' +
              //         'Temperatura: ' + temperature + ' &#8451;<br>' +
              //         'Wilgotność: ' + humidity + '%<br>' +
              //         'Jakość powietrza (AQI): ' + airQuality;
              //
              // $('#weather-data').html(weatherData);

              // Przesyłanie danych do servletu admin
              $.post('admin', $('#region-form').serialize());
              <% } %>

            },
            error: function() {
              $('#weather-data').html('<p>Wystąpił błąd podczas pobierania danych pogodowych.</p>');
            }
          });
        });
      </script>

  </div>
</div>
</body>
</html>