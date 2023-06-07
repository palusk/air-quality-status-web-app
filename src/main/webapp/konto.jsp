<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Account user = (Account) session.getAttribute("user");
    if (user == null){
        user = new Account();
        session.setAttribute("user", user);
    }

    String name = user.getImie();
    String email = user.getEmail();
    String userName = user.getLogin();


    Driver database = new Driver();

    int iduser = database.getUserId(userName);

    int regionID = database.selectRegionIdFromUsers(iduser);
    String regionName = database.selectRegionName(regionID);
    String latitude = database.selectLatitude(regionID);
    String longitude = database.selectLongitude(regionID);

%>
<!DOCTYPE html>
<html>
<head>
    <title>Konto</title>
    <link rel="stylesheet" type="text/css" href="konto_style.css">
</head>
<body>
<div class="container">
    <div class="user-info">
        <h2>Konto użytkownika</h2>
        <form action="login" method="post">
            <p2><b>Imię:</b> <%= name %></p2> </br></br>
            <p2><b>Email:</b>  <%= email %></p2></br></br>
            <p2><b>Nazwa użytkownika:</b>  <%= userName %></p2>  </br></br>

            <b>Region:</b> <%= regionName%>
            <select name="region">
                <option value="Stare Miasto">Stare Miasto</option>
                <option value="Kazimierz">Kazimierz</option>
                <option value="Podgórze">Podgórze</option>
                <option value="Nowa Huta">Nowa Huta</option>
                <option value="Krowodrza">Krowodrza</option>
                <option value="Dębniki">Dębniki</option>
                <option value="Zwierzyniec">Zwierzyniec</option>
                <option value="Bieżanów-Prokocim">Bieżanów-Prokocim</option>
                <option value="Bronowice">Bronowice</option>
                <option value="Czyżyny">Czyżyny</option>
            </select></br></br>

            <p2><b>Szerokość geograficzna:</b> <%= latitude%>  </p2> </br></br>
            <p2><b>Długość geograficzna:</b> <%= longitude%> </p2> </br></br>

            <button class="btn" type="submit" name="save" value="save">Zapisz</button>
        </form>
    </div>
</div>
</body>
</html>