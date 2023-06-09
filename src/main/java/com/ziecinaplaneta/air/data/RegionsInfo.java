package com.ziecinaplaneta.air.data;

public class RegionsInfo {
    private int idRegion;
    private String name;
    private String latitude;
    private String longitude;

    public RegionsInfo(int idRegion, String name, String latitude, String longitude) {
        this.idRegion = idRegion;
        this.name = name;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    // Gettery i settery dla zmiennych


    public int getIdRegion() {
        return idRegion;
    }

    public String getName() {
        return name;
    }

    public String getLatitude() {
        return latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setIdRegion(int idRegion) {
        this.idRegion = idRegion;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }
}