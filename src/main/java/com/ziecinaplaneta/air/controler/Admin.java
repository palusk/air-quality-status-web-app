package com.ziecinaplaneta.air.controler;

import com.ziecinaplaneta.air.database.Driver;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "admin", value = "/admin")
public class Admin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Driver database = new Driver();

        String changeUserId = request.getParameter("changePermission");
        String removeUserId = request.getParameter("deleteUser");
        String removeDataId = request.getParameter("deleteData");
        String changeDataId = request.getParameter("changeData");
        String addData = request.getParameter("addData");

        if(changeUserId != null) {
            String dropdownValue = request.getParameter("permissionsDropdown_" + changeUserId);
            database.changePermisions(Integer.valueOf(changeUserId), Integer.valueOf(dropdownValue));
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/admin.jsp");
        } else if(removeUserId != null){
            database.removeUser(Integer.valueOf(removeUserId));
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/admin.jsp");
        } else if(removeDataId != null){
            database.removeData(Integer.valueOf(removeDataId));
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/data.jsp");
        }else if(changeDataId != null){

            int idHistory = Integer.parseInt(request.getParameter("idHistory" + changeDataId));
            double latitude = Double.parseDouble(request.getParameter("latitude" + changeDataId));
            double longitude = Double.parseDouble(request.getParameter("longitude" + changeDataId));
            String city = request.getParameter("city" + changeDataId);
            String state = request.getParameter("state" + changeDataId);
            String country = request.getParameter("country" + changeDataId);
            double temperatureCelsius = Double.parseDouble(request.getParameter("temperatureCelsius" + changeDataId));
            int humidityPercent = Integer.parseInt(request.getParameter("humidityPercent" + changeDataId));
            int airQualityAQI = Integer.parseInt(request.getParameter("airQualityAQI" + changeDataId));
            String date = request.getParameter("date" + changeDataId);
            database.updateAirQualityHistory(idHistory, latitude, longitude, city, state, country, temperatureCelsius,
                    humidityPercent, airQualityAQI, date);
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/data.jsp");
        }else if(addData != null){

            String latitude = request.getParameter("latitude");
            String longitude = request.getParameter("longitude");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String country = request.getParameter("country");
            String temperature = request.getParameter("temperature");
            String humidity = request.getParameter("humidity");
            String airQuality = request.getParameter("airQuality");
            String date = request.getParameter("date");

            database.insertAirQualityHistory(Double.valueOf(latitude), Double.valueOf(longitude), city, state, country,
                    Integer.valueOf(temperature), Integer.valueOf(humidity),  Integer.valueOf(airQuality), date);
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/data.jsp");
        }


    }
}
