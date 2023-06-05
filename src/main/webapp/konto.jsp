<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Account user = (Account) session.getAttribute("user");
    if (user == null){
        user = new Account();
        session.setAttribute("user", user);
    }

    Driver database = new Driver();
    String name;
    // Pobierz tekst paragrafu z sesji
    String UserName = (String) session.getAttribute("user");
    if (UserName != null) {
        name = database.getNameByUsername(UserName);
            if (name == null) {
                name = "Empty Name";
            }

    } else{
        name = "Empty Name";
    }

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
            Email: </br></br>
            Nazwa użytkownika:  </br></br>

            <label for="city">Miasto:</label>
            <input type="text" id="city" name="city" placeholder="Wprowadź miasto" required>

            <label for="latitude">Szerokość geograficzna:</label>
            <input type="text" id="latitude" name="latitude" placeholder="Wprowadź szerokość geograficzną" required>

            <label for="longitude">Długość geograficzna:</label>
            <input type="text" id="longitude" name="longitude" placeholder="Wprowadź długość geograficzną" required>

            <button class="btn" type="submit" name="save" value="save">Zapisz</button>
        </form>
    </div>
</div>
</body>
</html>