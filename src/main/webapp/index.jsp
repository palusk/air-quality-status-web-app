<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Account user = (Account) session.getAttribute("user");
    if (user == null){
        user = new Account();
        session.setAttribute("user", user);
    }
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
            <% if (user.getUprawnienia() > 0) { %>
                <li><form action="login" method="post"><button class="btn2" type="submit" name="logout" value="logout">Wyloguj</button></form></li>
            <% }else{ %><li><a href="login.jsp"><button class="btn" type="button">Zaloguj</button></a></li> <% } %>
            <% if (user.getUprawnienia() == -1) { %>
            <li> <a  href="admin.jsp">ADMINISTRATION</a></li>
            <% } %>

        </ul>
    </header>
    <div id="interesting-facts">
        <h2>Ciekawostki</h2>
        <p>TUTAJ SE DAMY TEKST HEHE</p>
    </div>
    <div id="bg2">
        <h1>Dane pogodowe dla wybranych współrzędnych</h1>
        <form id="location-form" action="checkair" method="post">
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