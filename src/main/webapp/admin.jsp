<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%

%>
<!DOCTYPE html>
<html>
<head>
    <title>Konto</title>
    <link rel="stylesheet" type="text/css" href="konto_style.css">
</head>
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
                // Pobierz listę użytkowników z bazy danych
                Driver database = new Driver();
                List<Account> users = database.getUsersFromDatabase();

                // Wygeneruj wiersze tabeli na podstawie listy użytkowników
                for (Account user : users) {
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getImie() %></td>
                <td><%= user.getLogin() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getIdRegion() %></td>
                <td><%= user.getUprawnienia() %></td>
            </tr>

            <% } %>
        </table>
        </form>
    </div>
</div>
</body>
</html>