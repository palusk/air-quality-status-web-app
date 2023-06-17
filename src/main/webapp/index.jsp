<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="com.ziecinaplaneta.air.data.AirInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ziecinaplaneta.air.data.RegionsInfo" %>
<%@ page import="com.ziecinaplaneta.air.controler.API" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Account user = (Account) session.getAttribute("user");
    if (user == null){
        user = new Account();
        session.setAttribute("user", user);
    }

    Driver database = new Driver();
    List<String> trivias = database.getTriviaList();
    Random random = new Random();
    int randomNumber = random.nextInt(10);
    String trivia = trivias.get(randomNumber);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dane pogodowe</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="index_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="hide_air_quality.js"></script>

</head>
<body>
<div id="bg">
    <header action="index" class="header">
        <a  href="index.jsp"><img id="logobig" src="img/logo.png" alt="logo"></a>
        <ul id="textMenu">
            <li> <a  href="index.jsp">Strona główna</a></li>
            <% if (user.getUprawnienia() > 0) { %>
            <li><a onclick="hide()">Sprawdź jakość powietrza</a></li>
            <% } %>
            <li><a  href="zalecenia.jsp">Zalecenia</a></li>
            <% if (user.getUprawnienia() > 0) { %>
            <li> <a  href="konto.jsp">Konto</a></li>
            <% } %>
            <% if (user.getUprawnienia() > 0  || user.getUprawnienia() < 0) { %>
                <li><form action="login" method="post"><button class="btn2" type="submit" name="logout" value="logout">Wyloguj</button></form></li>
            <% }else{ %><li><a href="login.jsp"><button class="btn" type="button">Zaloguj</button></a></li> <% } %>
            <% if (user.getUprawnienia() == -1) { %>
            <li> <a  href="admin.jsp">ADMINISTRATION</a></li>
            <% } %>

        </ul>
    </header>
    <div id="interesting-facts">
        <h2>Ciekawostki</h2>
        <p><%= trivia %></p>
    </div>
    <div id="bg2">
        <h1>Dane pogodowe dla wybranych współrzędnych</h1>
        <form id="location-form" action="checkair" method="post">

            <input type="hidden" id="city-input" name="city">
            <input type="hidden" id="state-input" name="state">
            <input type="hidden" id="country-input" name="country">
            <input type="hidden" id="temperature-input" name="temperature">
            <input type="hidden" id="humidity-input" name="humidity">
            <input type="hidden" id="airQuality-input" name="airQuality">

            <label for="region-select">Wybierz region:</label>
            <select id="region-select">
                <option value="52.2297:21.0122:Warszawa">Warszawa</option>
                <option value="50.0647:19.9450:Kraków">Kraków</option>
                <option value="51.7592:19.4550:Łódź">Łódź</option>
                <option value="51.1079:17.0385:Wrocław">Wrocław</option>
                <option value="52.4064:16.9252:Poznań">Poznań</option>
                <option value="54.3520:18.6466:Gdańsk">Gdańsk</option>
                <option value="53.4289:14.5530:Szczecin">Szczecin</option>
                <option value="53.1235:18.0084:Bydgoszcz">Bydgoszcz</option>
                <option value="51.2465:22.5684:Lublin">Lublin</option>
                <option value="50.2649:19.0238:Katowice">Katowice</option>
            </select>
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
                var latlon = $('#region-select').val();
                var lat, lon, city;
                if (latlon) {
                    var latLonArray = latlon.split(":");
                    lat = latLonArray[0];
                    lon = latLonArray[1];
                    city = latLonArray[2];
                }

                // Pobranie danych pogodowych z API
                var keys = [
                    "64052ff3-73e2-4bab-9592-06e204bf2df2",
                    "f6b71fa4-2eb2-4903-9a75-48c4d67d143d",
                    "7a25e04d-4a52-44ae-9085-d55372d9fba5",
                    "c66a9ea4-c3e3-4a96-a2c8-5b095c48641e",
                    "1c39b65b-3ee3-44a8-ae65-65f082c298f2",
                    "20b95529-0f26-44c9-87d4-629ee406987e"
                ];
                var counter =  Math.floor(Math.random() * 6);
                var apiUrl = 'https://api.airvisual.com/v2/nearest_city?lat=' + lat + '&lon=' + lon + '&key=' + keys[counter];
                $.ajax({
                    url: apiUrl,
                    type: 'GET',
                    success: function(data) {
                        // Wyświetlenie danych na stronie
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

                        // Przesyłanie danych do servletu Checkair
                        $.post('checkair', $('#location-form').serialize());
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