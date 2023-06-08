<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="java.util.List" %>
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
        <table id="userTable">
            <tr>
                <th>ID</th>
                <th>Imię</th>
                <th>Nazwa użytkownika</th>
                <th>Email</th>
                <th>ID regionu</th>
                <th>Uprawnienia</th>
            </tr>
            <%
                List<Account> users = database.getUsersFromDatabase();
                for (Account user : users) {
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getImie() %></td>
                <td><%= user.getLogin() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getIdRegion() %></td>
                <td><%= user.getUprawnienia() %></td>
                <td><form action="admin" method="post">
                    <button class="btn" type="submit" name="deleteUser" value="<%= user.getId() %>">usun</button></form>
                </td>
                <td><form action="admin" method="post">
                    <select name="permissionsDropdown_<%= user.getId() %>">
                        <option value="-1">-1</option>
                        <option value="0">0</option>
                        <option value="1">1</option>
                    </select>
                     <button class="btn" type="submit" name="changePermission" value="<%= user.getId() %>">Zmień uprawnienia</button></form>
                </td>
            </tr>
            <% } %>
        </table>
        </form>
    </div>


    <div id="bg2">
        <h1>Dane pogodowe dla wybranych współrzędnych</h1>
        <form id="location-form">
            <label for="lat-input">Szerokość geograficzna (lat):</label>
            <input type="text" id="lat-input" name="lat">
            <br>
            <label for="lon-input">Długość geograficzna (lon):</label>
            <input type="text" id="lon-input" name="lon">
            <br>

            <input type="hidden" id="city-input" name="city">
            <input type="hidden" id="state-input" name="state">
            <input type="hidden" id="country-input" name="country">
            <input type="hidden" id="temperature-input" name="temperature">
            <input type="hidden" id="humidity-input" name="humidity">
            <input type="hidden" id="airQuality-input" name="airQuality">


            <button type="submit">Submit</button>
        </form>
        <div id="weather-data">
            <p>Wprowadź współrzędne geograficzne i kliknij "Submit", aby wygenerować dane pogodowe.</p>
        </div>
        <script>
            // Funkcja obsługująca formularz
            $('#location-form').submit(function(event) {
                event.preventDefault();

// Pobranie wartości z pól input
                var lat = $('#lat-input').val();
                var lon = $('#lon-input').val();

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

                        $('#city-input').val(city);
                        $('#state-input').val(state);
                        $('#country-input').val(country);
                        $('#temperature-input').val(temperature);
                        $('#humidity-input').val(humidity);
                        $('#airQuality-input').val(airQuality);

                        var weatherData = 'Miasto: ' + city + '<br>' +
                            'Stan: ' + state + '<br>' +
                            'Kraj: ' + country + '<br>' +
                            'Temperatura: ' + temperature + ' &#8451;<br>' +
                            'Wilgotność: ' + humidity + '%<br>' +
                            'Jakość powietrza (AQI): ' + airQuality;

                        $('#weather-data').html(weatherData);
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