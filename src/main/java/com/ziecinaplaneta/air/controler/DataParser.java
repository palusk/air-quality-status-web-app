package com.ziecinaplaneta.air.controler;

import org.json.JSONObject;

public class DataParser {

    private double latitude;
    private double longitude;
    private String city;
    private String state;
    private String country;
    private int temperatureCelsius;
    private int humidityPercent;
    private int airQualityAQI;

    public void parseData(String response) {
        try{
            JSONObject jsonResponse = new JSONObject(response);
            if (jsonResponse.getString("status").equals("success")) {
                JSONObject data = jsonResponse.getJSONObject("data");
                JSONObject location = data.getJSONObject("location");
                JSONObject current = data.getJSONObject("current");
                JSONObject pollution = current.getJSONObject("pollution");
                JSONObject weather = current.getJSONObject("weather");

                city = data.getString("city");
                state = data.getString("state");
                country = data.getString("country");
                latitude = location.getJSONArray("coordinates").getDouble(0);
                longitude = location.getJSONArray("coordinates").getDouble(1);
                temperatureCelsius = weather.getInt("tp");
                humidityPercent = weather.getInt("hu");
                airQualityAQI = pollution.getInt("aqius");
            }}catch(Exception e){
            System.out.println(e);
        }
    }

    public double getLatitude() {
        return latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getCountry() {
        return country;
    }

    public int getTemperatureCelsius() {
        return temperatureCelsius;
    }

    public int getHumidityPercent() {
        return humidityPercent;
    }

    public int getAirQualityAQI() {
        return airQualityAQI;
    }
}