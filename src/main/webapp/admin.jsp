<%@ page import="com.ziecinaplaneta.air.user.Account" %>
<%@ page import="com.ziecinaplaneta.air.database.Driver" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
Driver database = new Driver();
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
                <td>
                    <button onclick="database.removeUser(<%= user.getId() %>)">Usuń</button>
                </td>
                <td>
                    <select id="permissionsDropdown_<%= user.getId() %>">
                        <option value="-1">-1</option>
                        <option value="0">0</option>
                        <option value="1">1</option>
                    </select>
                    <button onclick="database.changePermisions(<%= user.getId() %>,2)">Zmień uprawnienia</button>
                </td>
            </tr>

            <% } %>
        </table>
        </form>
    </div>
</div>
</body>
</html>