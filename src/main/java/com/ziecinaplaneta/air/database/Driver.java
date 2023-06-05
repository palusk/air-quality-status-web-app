package com.ziecinaplaneta.air.database;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class Driver {
    static String jdbcUrl;
    static String username;
    static String password;
    static Connection connection;


    public Driver() {

        jdbcUrl = "jdbc:h2:D:/Program Files/IdeaProjects/air-quality-status_web_app2/air-quality-status_web_db";
        username = "admin";
        password = "admin";

        try {
            Class.forName("org.h2.Driver");
            connection = DriverManager.getConnection(jdbcUrl, username, password);

            // Statement statement = connection.createStatement();

            /* TEMPLATE DO ZAPYTAŃ SQL:
            String sqlUpdate = "INSERT INTO USERS (name, login, password, permissions) VALUES ('Admin', 'admin', 'admin', -1)";

            String sqlQuery = "SELECT * FROM USERS";

            statement.executeUpdate(sqlUpdate);

            ResultSet resultSet = statement.executeQuery(sqlQuery);

            while (resultSet.next()) {
                int ID = resultSet.getInt("iduser");
                String name = resultSet.getString("name");
                System.out.println("StudentID: " + ID + " Name: " + name);
            }

             */

            //---- TODO
            // connection.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static String hashPassword(String password) {
        byte[] KEY = { 0x01, 0x23, 0x45, 0x67, 0x67, 0x67, 0x67, 0x45 };
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(KEY);
            byte[] hashedBytes = md.digest(password.getBytes());

// Konwertowanie zahashowanych bajtów na tekstowy format
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }


    public boolean insertNewUser(String email, String name, String username, String password){
        try {
            String sqlUpdate = "INSERT INTO users (name, username, password, email) VALUES(?,?,?,?)";
            PreparedStatement stm = connection.prepareStatement(sqlUpdate);
            stm.setString(1, name);
            stm.setString(2, username);
            stm.setString(3, password);
            stm.setString(4, email);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e + " Warning: new user insert failed!");
            return false;
        }
    }

    public boolean validateLogin(String username, String password){
        try {
        password = hashPassword(password);

        String sqlQuery = "SELECT username, password FROM USERS WHERE username = ? AND password = ?";

        PreparedStatement stm= connection.prepareStatement(sqlQuery);
        stm.setString(1, username);
        stm.setString(2, password);

        ResultSet result = stm.executeQuery();

        if(result.next() == true){
            return true;
        }else return false;

        } catch (SQLException e) {
            System.out.println(e);
            e.printStackTrace();
            System.out.println("Warning: validateLogin query failed!");
            return false;
        }
    }

    public boolean checkIfUsernameExist(String username){
        try {
        String sqlQuery = "SELECT username FROM USERS WHERE username = ?";
        PreparedStatement stm= connection.prepareStatement(sqlQuery);
        stm.setString(1, username);

        ResultSet result = stm.executeQuery();
        if(result.next() == true){
            return true;
        }else return false;

    } catch (SQLException e) {
        System.out.println(e);
        e.printStackTrace();
        System.out.println("Warning: validateLogin query failed!");
        return false;
    }
    }

    public int getUserId(String username){
        try {
            String query = "SELECT iduser FROM users WHERE username = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, username);
            ResultSet result = stm.executeQuery();
            result.next();
            return result.getInt("iduser");
        } catch (SQLException e) {
            System.out.println("Warning: getUserId query failed!");
            return 0;
        }
    }


    public boolean insertDefaultLocation(String latitude, String longitude, int iduser){
        try {
            String sqlUpdate = "INSERT INTO DEFAULT_LOCATION (latitude, longitude, iduser) VALUES(?,?,?)";
            PreparedStatement stm = connection.prepareStatement(sqlUpdate);
            stm.setString(1, latitude);
            stm.setString(2, longitude);
            stm.setInt(3, iduser);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e + " Warning: default location insert failed!");
            return false;
        }
    }


}
