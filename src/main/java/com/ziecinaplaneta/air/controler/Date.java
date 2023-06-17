package com.ziecinaplaneta.air.controler;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Date {
    static String date;
    static boolean dataNotAssigned = true;

    public static boolean isDataNotAssigned() {
        return dataNotAssigned;
    }

    public Date() {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
        String formattedDate = currentDate.format(formatter);
        date =  formattedDate;
        dataNotAssigned = false;
        System.out.println(date);
    }

    public static String getDate() {
        return date;
    }

    public static void setDate(String date) {
        Date.date = date;
    }

    public static void olderDate() {

        java.time.LocalDate currentDate = java.time.LocalDate.parse(date, java.time.format.DateTimeFormatter.ofPattern("dd.MM.yyyy"));
        java.time.LocalDate newDate = currentDate.minusDays(1);
        date = newDate.format(java.time.format.DateTimeFormatter.ofPattern("dd.MM.yyyy"));
        System.out.println(date);
    }

    public static void newerDate() {

        java.time.LocalDate currentDate = java.time.LocalDate.parse(date, java.time.format.DateTimeFormatter.ofPattern("dd.MM.yyyy"));
        java.time.LocalDate newDate = currentDate.plusDays(1);
        date = newDate.format(java.time.format.DateTimeFormatter.ofPattern("dd.MM.yyyy"));
        System.out.println(date);
    }
}