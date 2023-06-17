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
      <li> W tym przedziale jakości powietrza, warunki są dobre i uważane za bezpieczne. </li >
      <li> Możesz swobodnie przebywać na zewnątrz i prowadzić normalne aktywności. </li >
      <li> Wciąż zaleca się monitorowanie lokalnych prognoz powietrza dla jakiejkolwiek zmiany w warunkach. </li >
    </ul >
  </li>
</ul>
<% }else if(data.getAirQualityAQI() >= 50 && data.getAirQualityAQI() <= 99){  %>
<ul class="lista-podpunktow" >
  <li>
    <span class="tytul-podpunktu" > Przedział AQI 50-99 (Umiarkowana jakość powietrza): </span >
    <ul class="lista-podpunktow-podstawowa" >
      <li> W tym przedziale jakości powietrza, jakość powietrza jest akceptowalna, ale mogą występować pewne zanieczyszczenia. </li >
      <li> Jeśli jesteś osobą wrażliwą na problemy związane z jakością powietrza, takie jak osoby z astmą lub innymi schorzeniami układu oddechowego, rozważ ograniczenie czasu spędzanego na zewnątrz w miejscach o dużym ruchu lub zanieczyszczeniach. </li >
      <li> Warto monitorować lokalne prognozy powietrza i unikać miejsc, gdzie jakość powietrza może być gorsza, na przykład obszarów z dużym zanieczyszczeniem. </li >
    </ul>
  </li>
</ul>
<% }else if(data.getAirQualityAQI() >= 100 && data.getAirQualityAQI() <= 149){  %>
<ul class="lista-podpunktow" >
  <li>
    <span class="tytul-podpunktu" > Przedział AQI 100-149 (Niezdrowa dla wrażliwych grup): </span >
    <ul class="lista-podpunktow-podstawowa" >
      <li> W tym przedziale jakości powietrza, osoby wrażliwe, takie jak dzieci, osoby starsze i osoby z problemami zdrowotnymi, mogą odczuwać negatywne skutki związane z jakością powietrza. </li >
      <li> Osoby wrażliwe powinny ograniczyć intensywne aktywności na zewnątrz i unikać miejsc o dużym zanieczyszczeniu powietrza. </li >
      <li> Zaleca się monitorowanie lokalnych prognoz powietrza i stosowanie się do zaleceń zdrowotnych w przypadku wystąpienia wysokiej jakości powietrza. </li >
    </ul>
  </li>
</ul>
<% }else if(data.getAirQualityAQI() >= 150){  %>
<ul class="lista-podpunktow" >
  <li>
    <span class="tytul-podpunktu" > Przedział AQI 150+ (Bardzo niezdrowa lub niebezpieczna jakość powietrza): </span >
    <ul class="lista-podpunktow-podstawowa" >
      <li> W tym przedziale jakości powietrza, jakość powietrza jest bardzo zła i może stanowić poważne zagrożenie dla zdrowia. </li >
      <li> Zaleca się unikanie aktywności na zewnątrz, zwłaszcza dla osób wrażliwych i wszystkich innych osób. </li >
      <li> W przypadku konieczności przebywania na zewnątrz, należy nosić odpowiednie maski ochronne, które filtrują cząstki zanieczyszczeń powietrza. </li >
      <li>Monitoruj lokalne prognozy powietrza i stosuj się do wszelkich zaleceń zdrowotnych i ostrzeżeń wydanych przez lokalne władze lub służby zdrowia.</li>
    </ul>
  </li>
</ul>
<% }
 } %>
</body>
</html>
