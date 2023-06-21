<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="com.ziecinaplaneta.air.controler.API" %>
<%@ page import="com.ziecinaplaneta.air.data.AirInfo" %>
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
    <link rel="stylesheet" href="favourite_places.css">
    <title>Ulubione miasta</title>
<%--    <script src="https://maps.googleapis.com/maps/api/js?key=TWOJ_KLUCZ_API&callback=initMap" async defer></script>--%>
<%--    <script src="map.js"></script>--%>
</head>
<body>
<div id="bg3"></div>
<header class="header">
    <br id="textMenu2">
    <li> <a  href="index.jsp">Wróć do strony głównej</a></li></br>
</header>

<div class="container">
    <div class="favourite-places-info">
        <h2>Statystyki z ulubionych miast:</h2>
        <form action="login" method="post">
            <p2><b>Imię:</b> <%= name %></p2> </br></br>
            <p2><b>Email:</b>  <%= email %></p2></br></br>
            <p2><b>Nazwa użytkownika:</b>  <%= userName %></p2>  </br></br>

            <b>Twoje miasto:</b> <%= regionName%>
            <select name="region">
                <option value="1">Warszawa</option>
                <option value="2">Kraków</option>
                <option value="3">Łódź</option>
                <option value="4">Wrocław</option>
                <option value="5">Poznań</option>
                <option value="6">Gdańsk</option>
                <option value="7">Szczecin</option>
                <option value="8">Bydgoszcz</option>
                <option value="9">Lublin</option>
                <option value="10">Katowice</option>
            </select></br></br>

            <p2><b>Szerokość geograficzna:</b> <%= latitude%>  </p2> </br></br>
            <p2><b>Długość geograficzna:</b> <%= longitude%> </p2> </br></br>

            <button class="btn" type="submit" name="save" value="save">Zapisz</button></br></br>

            <p2><b>Wybierz swoje ulubione miasta:</b> <%= name %></p2> </br></br>

        </form>
    </div>
</div>





<%--<h1>Mapa Polski</h1>--%>
<%--<div id="map"></div>--%>


</body>
</html>
