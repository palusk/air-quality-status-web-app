package com.ziecinaplaneta.air.data;

public class Filtr {

    private static double minTemp;
    private static double maxTemp;

    private static double minAqi;
    private static double maxAqi;

    private static double minHum;


    private static double maxHum;

    private static boolean minTempAssigned = false;
    private static boolean maxTempAssigned= false;

    private static boolean minAqiAssigned = false;
    private static boolean maxAqiAssigned = false;

    private static boolean minHumAssigned = false;
    private static boolean maxHumAssigned = false;

    public static boolean isMinTempAssigned() {
        return minTempAssigned;
    }

    public static void setMinTempAssigned(boolean minTempAssigned) {
        Filtr.minTempAssigned = minTempAssigned;
    }

    public static boolean isMaxTempAssigned() {
        return maxTempAssigned;
    }

    public static void setMaxTempAssigned(boolean maxTempAssigned) {
        Filtr.maxTempAssigned = maxTempAssigned;
    }

    public static boolean isMinAqiAssigned() {
        return minAqiAssigned;
    }

    public static void setMinAqiAssigned(boolean minAqiAssigned) {
        Filtr.minAqiAssigned = minAqiAssigned;
    }

    public static boolean isMaxAqiAssigned() {
        return maxAqiAssigned;
    }

    public static void setMaxAqiAssigned(boolean maxAqiAssigned) {
        Filtr.maxAqiAssigned = maxAqiAssigned;
    }

    public static boolean isMinHumAssigned() {
        return minHumAssigned;
    }

    public static void setMinHumAssigned(boolean minHumAssigned) {
        Filtr.minHumAssigned = minHumAssigned;
    }

    public static boolean isMaxHumAssigned() {
        return maxHumAssigned;
    }

    public static void setMaxHumAssigned(boolean maxHumAssigned) {
        Filtr.maxHumAssigned = maxHumAssigned;
    }




    public static double getMinTemp() {
        return minTemp;
    }

    public static void setMinTemp(double minTemp) {
        Filtr.minTemp = minTemp;
    }

    public static double getMaxTemp() {
        return maxTemp;
    }

    public static void setMaxTemp(double maxTemp) {
        Filtr.maxTemp = maxTemp;
    }

    public static double getMinAqi() {
        return minAqi;
    }

    public static void setMinAqi(double minAqi) {
        Filtr.minAqi = minAqi;
    }

    public static double getMaxAqi() {
        return maxAqi;
    }

    public static void setMaxAqi(double maxAqi) {
        Filtr.maxAqi = maxAqi;
    }

    public static double getMinHum() {
        return minHum;
    }

    public static void setMinHum(double minHum) {
        Filtr.minHum = minHum;
    }

    public static double getMaxHum() {
        return maxHum;
    }

    public static void setMaxHum(double maxHum) {
        Filtr.maxHum = maxHum;
    }

}
