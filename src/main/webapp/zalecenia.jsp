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
  <link rel="stylesheet" href="zalecenia_style.css">
  <title>Zalecenia</title>
</head>
<body>
<div id="bg3"></div>
<header class="header">
  <br id="textMenu2">
    <li> <a  href="index.jsp">Wróć do strony głównej</a></li></br>
  <% if(user.getIdRegion() == 0) { %>
  <li> <a  href="konto.jsp">Aby zobaczyć aktualne zalecenia dla twojego regionu, kliknij aby przejść do panelu konta użytkownika i wybierz swoje miasto.</a></li>
  <% } %>
</header>

<% if(user.getIdRegion() != 0) {
 AirInfo data = API.getAirData(latitude, longitude);
 if(data.getAirQualityAQI() <= 49) { %>
<ul class="lista-podpunktow" >
  <li>
    <span class="tytul-podpunktu" > Przedział AQI 0-49 (Dobra jakość powietrza): </span >
    <ul class="lista-podpunktow-podstawowa" >
      <li> <%= database.selectRecommendationOne(1)%> </li >
      <li> <%= database.selectRecommendationTwo(1)%> </li >
      <li> <%= database.selectRecommendationThree(1)%> </li >
    </ul >
  </li>
</ul>
<% }else if(data.getAirQualityAQI() >= 50 && data.getAirQualityAQI() <= 99){  %>
<ul class="lista-podpunktow" >
  <li>
    <span class="tytul-podpunktu" > Przedział AQI 50-99 (Umiarkowana jakość powietrza): </span >
    <ul class="lista-podpunktow-podstawowa" >
      <li> <%= database.selectRecommendationOne(2)%> </li >
      <li> <%= database.selectRecommendationTwo(2)%> </li >
      <li> <%= database.selectRecommendationThree(2)%> </li >
    </ul>
  </li>
</ul>
<% }else if(data.getAirQualityAQI() >= 100 && data.getAirQualityAQI() <= 149){  %>
<ul class="lista-podpunktow" >
  <li>
    <span class="tytul-podpunktu" > Przedział AQI 100-149 (Niezdrowa dla wrażliwych grup): </span >
    <ul class="lista-podpunktow-podstawowa" >
      <li> <%= database.selectRecommendationOne(3)%> </li >
      <li> <%= database.selectRecommendationTwo(3)%> </li >
      <li> <%= database.selectRecommendationThree(3)%> </li >
    </ul>
  </li>
</ul>
<% }else if(data.getAirQualityAQI() >= 150){  %>
<ul class="lista-podpunktow" >
  <li>
    <span class="tytul-podpunktu" > Przedział AQI 150+ (Bardzo niezdrowa lub niebezpieczna jakość powietrza): </span >
    <ul class="lista-podpunktow-podstawowa" >
      <li> <%= database.selectRecommendationOne(4)%> </li >
      <li> <%= database.selectRecommendationTwo(4)%> </li >
      <li> <%= database.selectRecommendationThree(4)%> </li >
    </ul>
  </li>
</ul>
<% }
 } %>
</body>
</html>
