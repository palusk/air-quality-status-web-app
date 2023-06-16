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
        <p>TUTAJ SE DAMY TEKST HEHE</p>
    </div>
    <div id="bg2">
        <h1>Dane pogodowe dla wybranych współrzędnych</h1>


        <label for="region-select">Wybierz region:</label>
        <select id="region-select">
            <option value="1">Stare Miasto</option>
            <option value="2">Kazimierz</option>
            <option value="3">Podgórze</option>
            <option value="4">Nowa Huta</option>
            <option value="5">Krowodrza</option>
            <option value="6">Dębniki</option>
            <option value="7">Zwierzyniec</option>
            <option value="8">Bieżanów-Prokocim</option>
            <option value="9">Bronowice</option>
            <option value="10">Czyżyny</option>
        </select>

            <button type="submit">Submit</button>
        </form>
        <div id="weather-data">
            <p>Wprowadź współrzędne geograficzne i kliknij "Submit", aby wygenerować dane pogodowe.</p>
        </div>


    </div>

</div>

</body>
</html>