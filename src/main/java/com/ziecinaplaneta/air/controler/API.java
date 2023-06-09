package com.ziecinaplaneta.air.controler;

import com.ziecinaplaneta.air.data.AirInfo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class API{

    static int counter = 0;
    static String[] keys = {
            "64052ff3-73e2-4bab-9592-06e204bf2df2",
            "f6b71fa4-2eb2-4903-9a75-48c4d67d143d",
            "7a25e04d-4a52-44ae-9085-d55372d9fba5",
            "c66a9ea4-c3e3-4a96-a2c8-5b095c48641e",
            "1c39b65b-3ee3-44a8-ae65-65f082c298f2",
             "20b95529-0f26-44c9-87d4-629ee406987e"
    };


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


    public static AirInfo getAirData(String lat, String lon){
        AirInfo data;
        String result = new String();
        try {
            String apiUrl = "https://api.airvisual.com/v2/nearest_city?lat=" + lat + "&lon=" + lon + "&key=" + keys[counter];
            if(counter<5)counter++;
            else counter = 0;

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










