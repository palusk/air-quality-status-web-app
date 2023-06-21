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

    int countF = 0;

%>
<!DOCTYPE html>
<html>
<head>
    <title>Konto</title>
    <link rel="stylesheet" type="text/css" href="konto_style.css">
</head>
<body>
<header class="header">
    <ul id="textMenu2">
        <li> <a  href="index.jsp">Wróć do strony głównej</a></li>
    </ul>
</header>
<div class="container">
    <div class="user-info">
        <h2>Konto użytkownika</h2>
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
        </form>

            <p2><b>Wybierz swoje ulubione miasta:</b></p2> </br></br>
            <form action="favourite" method="post">
                <input type="checkbox" name="regionF1" value="1">Warszawa<br>
                <input type="checkbox" name="regionF2" value="2">Kraków<br>
                <input type="checkbox" name="regionF3" value="3">Łódź<br>
                <input type="checkbox" name="regionF4" value="4">Wrocław<br>
                <input type="checkbox" name="regionF5" value="5">Poznań<br>
                <input type="checkbox" name="regionF6" value="6">Gdańsk<br>
                <input type="checkbox" name="regionF7" value="7">Szczecin<br>
                <input type="checkbox" name="regionF8" value="8">Bydgoszcz<br>
                <input type="checkbox" name="regionF9" value="9">Lublin<br>
                <input type="checkbox" name="regionF10" value="10">Katowice<br>

            <button class="btn" type="submit" name="saveF" value="saveF">Zapisz ulubione miasta</button></br></br>


            </form>
    </div>
</div>
</body>
</html>