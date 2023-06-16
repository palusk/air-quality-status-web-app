package com.ziecinaplaneta.air.controler;

import com.ziecinaplaneta.air.data.AirInfo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class API{


    private static String sendGetRequest(String apiUrl) throws IOException {
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        StringBuilder response = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
        }

        connection.disconnect();
        return response.toString();
    }


    public static AirInfo getAirData(String lan, String lon){
        AirInfo data;
        String apiKey = "64052ff3-73e2-4bab-9592-06e204bf2df2";
        String result = new String();
        try {
            String apiUrl = "https://api.airvisual.com/v2/nearest_city?lat=" + lan + "&lon=" + lon + "&key=" + apiKey;
            result = sendGetRequest(apiUrl);
            System.out.println(result);
        } catch (IOException e) {
            e.printStackTrace();
        }

        DataParser parser = new DataParser();
        parser.parseData(result);

        data = new AirInfo(
                parser.getLatitude(),
                parser.getLongitude(),
                parser.getCity(),
                parser.getState(),
                parser.getCountry(),
                parser.getTemperatureCelsius(),
                parser.getHumidityPercent(),
                parser.getAirQualityAQI()
        );

        System.out.println(data.toString());
        return data;
    }
}










