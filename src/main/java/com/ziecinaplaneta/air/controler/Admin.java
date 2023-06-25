package com.ziecinaplaneta.air.controler;

import com.ziecinaplaneta.air.data.AirInfo;
import com.ziecinaplaneta.air.data.Filtr;
import com.ziecinaplaneta.air.data.RegionsInfo;
import com.ziecinaplaneta.air.database.Driver;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

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
        String regionUpdateData = request.getParameter("regionUpdateData");
        String newerData = request.getParameter("newerData");
        String olderData = request.getParameter("olderData");
        String filtruj = request.getParameter("filtruj");
        String reset = request.getParameter("reset");


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

        }else if(regionUpdateData != null) {


            List<RegionsInfo> regionsInfo = database.getRegionsDatabase();
            for (RegionsInfo region : regionsInfo) {

                AirInfo airInfo;

                String latitude = region.getLatitude();
                String longitude = region.getLongitude();

                airInfo = API.getAirData(latitude, longitude);


                LocalDate currentDate = LocalDate.now();
                // Create a DateTimeFormatter for the desired date format
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
                // Format the current date using the formatter
                String date = currentDate.format(formatter);


                database.insertAirQualityHistory(airInfo.getLatitude(), airInfo.getLongitude(), region.getName(), airInfo.getState(), airInfo.getCountry(),
                        airInfo.getTemperatureCelsius(), airInfo.getHumidityPercent(), airInfo.getAirQualityAQI(), date);


            }
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/data.jsp");

        }else if(newerData != null) {
            Date.newerDate();
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/historical_data.jsp");
        }else if(olderData != null) {
            Date.olderDate();
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/historical_data.jsp");
        }else if(filtruj != null) {

            String minTemp = request.getParameter("minTemp");
            String maxTemp = request.getParameter("maxTemp");
            String minAqi = request.getParameter ("minAQI");
            String maxAqi = request.getParameter ("maxAQI");
            String minHum = request.getParameter ("minHum");
            String maxHum = request.getParameter ("maxHum");


            if(!minTemp.isEmpty() ){Filtr.setMinTempAssigned(true); Filtr.setMinTemp(Double.valueOf(minTemp)); } else { Filtr.setMinTempAssigned(false); }
            if(!maxTemp.isEmpty() ){Filtr.setMaxTempAssigned(true);Filtr.setMaxTemp(Double.valueOf(maxTemp));} else { Filtr.setMaxTempAssigned(false); }
            if(!minAqi.isEmpty() ){Filtr.setMinAqiAssigned(true);Filtr.setMinAqi(Double.valueOf(minAqi));} else { Filtr.setMinAqiAssigned(false); }
            if(!maxAqi.isEmpty() ){Filtr.setMaxAqiAssigned(true);Filtr.setMaxAqi(Double.valueOf(maxAqi));} else { Filtr.setMaxAqiAssigned(false); }
            if(!minHum.isEmpty() ){Filtr.setMinHumAssigned(true);Filtr.setMinHum(Double.valueOf(minHum));} else { Filtr.setMinHumAssigned(false); }
            if(!maxHum.isEmpty() ){Filtr.setMaxHumAssigned(true);Filtr.setMaxHum(Double.valueOf(maxHum));} else { Filtr.setMaxHumAssigned(false); }

            response.sendRedirect("/air_quality_status_web_app2_war_exploded/filterData.jsp");
        }else if(reset != null) {
            Filtr.setMinTempAssigned(false);
            Filtr.setMaxTempAssigned(false);
            Filtr.setMinAqiAssigned(false);
            Filtr.setMaxAqiAssigned(false);
            Filtr.setMinHumAssigned(false);
            Filtr.setMaxHumAssigned(false);
            response.sendRedirect("/air_quality_status_web_app2_war_exploded/filterData.jsp");
        }
    }


}
