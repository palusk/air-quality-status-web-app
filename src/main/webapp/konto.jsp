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
           <p2>Imię: <%= name %></p2> </br></br>
            <p2>Email:  <%= email %></p2></br></br>
            <p2>Nazwa użytkownika:  <%= userName %></p2>  </br></br>

            <label for="region">Miasto:</label>
            <input type="text" id="region" name="region" placeholder="Wybierz region Krakowa" required>

            <p2>Szerokość geograficzna:  </p2> </br></br>
            <p2>Długość geograficzna:  </p2> </br></br>

            <button class="btn" type="submit" name="save" value="save">Zapisz</button>
        </form>
    </div>
</div>
</body>
</html>