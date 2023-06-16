package com.ziecinaplaneta.air.data;

public class RegionsInfo {
    private int idRegion;
    private String name;
    private String latitude;
    private String longitude;

    public String getPlaceID() {
        return placeID;
    }

    public void setPlaceID(String placeID) {
        this.placeID = placeID;
    }

    private String placeID;

    public RegionsInfo(int idRegion, String name, String latitude, String longitude, String placeID) {
        this.idRegion = idRegion;
        this.name = name;
        this.latitude = latitude;
        this.longitude = longitude;
        this.placeID = placeID;
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