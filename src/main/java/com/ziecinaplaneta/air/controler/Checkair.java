package com.ziecinaplaneta.air.controler;
import com.ziecinaplaneta.air.data.AirInfo;
import com.ziecinaplaneta.air.data.RegionsInfo;
import com.ziecinaplaneta.air.database.Driver;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "checkair", value = "/checkair")
public class Checkair extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String nowaZawartosc = "Nowa zawartość paragrafu";
        request.setAttribute("nowaZawartosc", nowaZawartosc);
        request.getRequestDispatcher("index.jsp").forward(request, response);

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String getSingleData = request.getParameter("getSingleData");
        if(getSingleData != null) {
        int id = Integer.valueOf(request.getParameter("selectedRegion"));
        System.out.println(getSingleData);


            Driver database = new Driver();
            List<RegionsInfo> regionsInfo = database.getRegionsDatabase();
            for (RegionsInfo region : regionsInfo) {
                if(region.getIdRegion() == id) {

                    String latitude = region.getLatitude();
                    String longitude = region.getLongitude();
                    AirInfo airInfo = API.getAirData(latitude, longitude);

                    LocalDate currentDate = LocalDate.now();
                    // Create a DateTimeFormatter for the desired date format
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
                    // Format the current date using the formatter
                    String date = currentDate.format(formatter);

                    database.insertAirQualityHistory(airInfo.getLatitude(), airInfo.getLongitude(), airInfo.getCity(), airInfo.getState(), airInfo.getCountry(),
                            airInfo.getTemperatureCelsius(), airInfo.getHumidityPercent(), airInfo.getAirQualityAQI(), date);

                    int idHistory = airInfo.getIdHistory();
                    String city =  airInfo.getCity();
                    String state =  airInfo.getState();
                    String country =  airInfo.getCountry();
                    double temperature =  airInfo.getTemperatureCelsius();
                    int humidity =  airInfo.getHumidityPercent();
                    int airQuality =  airInfo.getAirQualityAQI();

                    // Utwórz wiersz tabeli
                    String tableRow = "<tr>" +
                            "<td>" + idHistory + "</td>" +
                            "<td>" + latitude + "</td>" +
                            "<td>" + longitude + "</td>" +
                            "<td>" + city + "</td>" +
                            "<td>" + state + "</td>" +
                            "<td>" + country + "</td>" +
                            "<td>" + temperature + "</td>" +
                            "<td>" + humidity + "</td>" +
                            "<td>" + airQuality + "</td>" +
                            "<td>" + date + "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "</tr>";

                    // Dodaj wiersz do tabeli
                    HttpSession session = request.getSession();
                    session.setAttribute("tableRows", tableRow);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/air_quality_status_web_app2_war_exploded/index.jsp");
                    dispatcher.forward(request, response);
                }
            }

        }

    }

}
