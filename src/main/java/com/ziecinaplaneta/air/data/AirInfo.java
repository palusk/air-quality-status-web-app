package com.ziecinaplaneta.air.data;

public class AirInfo {
    private int idHistory;
    private double latitude;
    private double longitude;
    private String city;
    private String state;
    private String country;
    private int temperatureCelsius;
    private int humidityPercent;
    private int airQualityAQI;
    private String date;

    public AirInfo(int idHistory, double latitude, double longitude, String city, String state, String country,
                       int temperatureCelsius, int humidityPercent, int airQualityAQI, String date) {
        this.idHistory = idHistory;
        this.latitude = latitude;
        this.longitude = longitude;
        this.city = city;
        this.state = state;
        this.country = country;
        this.temperatureCelsius = temperatureCelsius;
        this.humidityPercent = humidityPercent;
        this.airQualityAQI = airQualityAQI;
        this.date = date;
    }

    public AirInfo(double latitude, double longitude, String city, String state, String country,
                   int temperatureCelsius, int humidityPercent, int airQualityAQI) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.city = city;
        this.state = state;
        this.country = country;
        this.temperatureCelsius = temperatureCelsius;
        this.humidityPercent = humidityPercent;
        this.airQualityAQI = airQualityAQI;
    }

    // Gettery i settery dla zmiennych

    public int getIdHistory() {
        return idHistory;
    }

    public void setIdHistory(int idHistory) {
        this.idHistory = idHistory;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public double getTemperatureCelsius() {
        return temperatureCelsius;
    }

    public void setTemperatureCelsius(int temperatureCelsius) {
        this.temperatureCelsius = temperatureCelsius;
    }

    public int getHumidityPercent() {
        return humidityPercent;
    }

    public void setHumidityPercent(int humidityPercent) {
        this.humidityPercent = humidityPercent;
    }

    public int getAirQualityAQI() {
        return airQualityAQI;
    }

    public void setAirQualityAQI(int airQualityAQI) {
        this.airQualityAQI = airQualityAQI;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "AirInfo{" +
                "latitude=" + latitude +
                ", longitude=" + longitude +
                ", city='" + city + '\'' +
                ", state='" + state + '\'' +
                ", country='" + country + '\'' +
                ", temperatureCelsius=" + temperatureCelsius +
                ", humidityPercent=" + humidityPercent +
                ", airQualityAQI=" + airQualityAQI +
                '}';
    }
}