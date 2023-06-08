package com.ziecinaplaneta.air.controler;
import com.ziecinaplaneta.air.database.Driver;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "checkair", value = "/checkair")
public class Checkair extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("srvleeeeeeeey");
        Driver database = new Driver();

        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        String temperature = request.getParameter("temperature");
        String humidity = request.getParameter("humidity");
        String airQuality = request.getParameter("airQuality");
        String latitude = request.getParameter("lat");
        String longitude = request.getParameter("lon");

        LocalDate currentDate = LocalDate.now();

        // Create a DateTimeFormatter for the desired date format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");

        // Format the current date using the formatter
        String date = currentDate.format(formatter);
        if(!latitude.isEmpty() && !longitude.isEmpty()) {
            database.insertAirQualityHistory(Double.valueOf(latitude), Double.valueOf(longitude), city, state,
                    country, Double.valueOf(temperature), Integer.valueOf(humidity), Integer.valueOf(airQuality),
                    date);
        }
    }

}
