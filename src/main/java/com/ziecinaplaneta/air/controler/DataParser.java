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

    public static void main(String[] args) {
        String response = "{\"status\":\"success\",\"data\":{\"city\":\"Chapaev\",\"state\":\"Batys Qazaqstan\",\"country\":\"Kazakhstan\",\"location\":{\"type\":\"Point\",\"coordinates\":[51.16667,50.2]},\"current\":{\"pollution\":{\"ts\":\"2023-06-16T15:00:00.000Z\",\"aqius\":76,\"mainus\":\"p2\",\"aqicn\":34,\"maincn\":\"p2\"},\"weather\":{\"ts\":\"2023-06-16T17:00:00.000Z\",\"tp\":25,\"pr\":1002,\"hu\":49,\"ws\":1.68,\"wd\":115,\"ic\":\"10n\"}}}}";

        DataParser dataParser = new DataParser();
        dataParser.parseData(response);

        // Wyświetlanie danych
        System.out.println("City: " + dataParser.getCity());
        System.out.println("State: " + dataParser.getState());
        System.out.println("Country: " + dataParser.getCountry());
        System.out.println("Latitude: " + dataParser.getLatitude());
        System.out.println("Longitude: " + dataParser.getLongitude());
        System.out.println("Temperature (°C): " + dataParser.getTemperatureCelsius());
        System.out.println("Humidity (%): " + dataParser.getHumidityPercent());
        System.out.println("Air Quality (AQI): " + dataParser.getAirQualityAQI());
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