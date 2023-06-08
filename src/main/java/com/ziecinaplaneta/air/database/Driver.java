package com.ziecinaplaneta.air.database;
import com.ziecinaplaneta.air.user.Account;
import com.ziecinaplaneta.air.data.AirInfo;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Driver {
    static String jdbcUrl;
    static String username;
    static String password;
    static Connection connection;

    public Driver() {

        jdbcUrl = "jdbc:h2:C:/Users/mateu/IdeaProjects/air-quality-status_web_app2/air-quality-status_web_db";
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


    public String getNameByUsername(String username){
        try {
            String query = "SELECT name FROM users WHERE username = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, username);
            ResultSet result = stm.executeQuery();
            result.next();
            return result.getString("name");
        } catch (SQLException e) {
            System.out.println("Warning: getNameByUsername query failed!");
            return "Empty Name";
        }
    }

    public String getEmailByUsername(String username){
        try {
            String query = "SELECT email FROM users WHERE username = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, username);
            ResultSet result = stm.executeQuery();
            result.next();
            return result.getString("email");
        } catch (SQLException e) {
            System.out.println("Warning: getEmailByUsername query failed!");
            return "Empty email";
        }
    }

    public List<Account> getUsersFromDatabase() {
        List<Account> users = new ArrayList<>();
        try {
            String query = "SELECT * FROM users";
            PreparedStatement stm = connection.prepareStatement(query);
            ResultSet result = stm.executeQuery();
            int counter = 0;
            while (result.next()){
                users.add(new Account());
                users.get(counter).setId(result.getInt("IDUSER"));
                users.get(counter).setIdRegion(result.getInt("IDREGION"));
                users.get(counter).setImie(result.getString("NAME"));
                users.get(counter).setLogin(result.getString("USERNAME"));
                users.get(counter).setEmail(result.getString("EMAIL"));
                users.get(counter).setUprawnienia(result.getInt("PERMISSIONS"));
                counter++;
            }
            return users;
        } catch (SQLException e) {
            System.out.println("Warning: no users load!");
            return users;
        }
    }

    public void removeUser(int userId) {
        try {
            String sqlUpdate = "DELETE FROM users WHERE iduser = ?";
            PreparedStatement stm = connection.prepareStatement(sqlUpdate);
            stm.setInt(1, userId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + " Warning: no user deleted");
        }
    }



    public void changePermisions(int userId, int permisions) {
        try {
            String sqlUpdate = "UPDATE users SET PERMISSIONS = ? WHERE IDUSER = ?";
            PreparedStatement stm = connection.prepareStatement(sqlUpdate);
            stm.setInt(1, permisions);
            stm.setInt(2, userId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + " Warning: no user deleted");
        }
    }

    public int selectRegionId(String regionName){
        try {
            String query = "SELECT idregion FROM regions WHERE name = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, regionName);
            ResultSet result = stm.executeQuery();
            result.next();
            return result.getInt("idregion");
        } catch (SQLException e) {
            System.out.println("Warning: selectRegionId query failed!");
            return 0;
        }
    }

    public boolean insertIdRegionIntoUsers(int idregion, int iduser){
        try {
            String sqlUpdate = "UPDATE users SET idregion = ? WHERE iduser = ?";
            PreparedStatement stm = connection.prepareStatement(sqlUpdate);
            stm.setInt(1, idregion);
            stm.setInt(2, iduser);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e + " Warning: insertIdRegionIntoUsers failed!");
            return false;
        }
    }


    public int selectRegionIdFromUsers(int iduser){
        try {
            String query = "SELECT idregion FROM users WHERE iduser = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setInt(1, iduser);
            ResultSet result = stm.executeQuery();
            result.next();
            return result.getInt("idregion");
        } catch (SQLException e) {
            System.out.println("Warning: selectRegionIdFromUsers query failed!");
            return 0;
        }
    }


    public String selectRegionName(int idregion){
        try {
            String query = "SELECT name FROM regions WHERE idregion = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setInt(1, idregion);
            ResultSet result = stm.executeQuery();
            result.next();
            return result.getString("name");
        } catch (SQLException e) {
            System.out.println("Warning: selectRegionName query failed!");
            System.out.println(e);
            return "Empty region name";
        }
    }

    public String selectLatitude(int idregion){
        try {
            String query = "SELECT latitude FROM regions WHERE idregion = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setInt(1, idregion);
            ResultSet result = stm.executeQuery();
            result.next();
            return result.getString("latitude");
        } catch (SQLException e) {
            System.out.println("Warning: selectLatitude query failed!");
            System.out.println(e);
            return "Empty latitude";
        }
    }


    public String selectLongitude(int idregion){
        try {
            String query = "SELECT longitude FROM regions WHERE idregion = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setInt(1, idregion);
            ResultSet result = stm.executeQuery();
            result.next();
            return result.getString("longitude");
        } catch (SQLException e) {
            System.out.println("Warning: selectLongitude query failed!");
            System.out.println(e);
            return "Empty longitude";
        }
    }

    public List<AirInfo> getAirDataDatabase() {
        List<AirInfo> data = new ArrayList<>();
        try {
            String query = "SELECT * FROM AIR_QUALITY_HISTORY";
            PreparedStatement stm = connection.prepareStatement(query);
            ResultSet result = stm.executeQuery();
            while (result.next()){
                data.add(new AirInfo(
                        result.getInt("IDHISTORY"),
                        result.getDouble("LATITUDE"),
                        result.getDouble("LONGITUDE"),
                        result.getString("CITY"),
                        result.getString("STATE"),
                        result.getString("COUNTRY"),
                        result.getInt("TEMPERATURECELSIUS"),
                        result.getInt("HUMIDITYPERCENT"),
                        result.getInt("AIRQUALITYAQI"),
                        result.getString("DATE")
                ));
            }
            return data;
        } catch (SQLException e) {
            System.out.println(e+"Warning: no data load!");
            return data;
        }
    }

    public void removeData(int dataId) {
        try {
            String sqlUpdate = "DELETE FROM AIR_QUALITY_HISTORY WHERE IDHISTORY = ?";
            PreparedStatement stm = connection.prepareStatement(sqlUpdate);
            stm.setInt(1, dataId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + " Warning: no data deleted");
        }
    }

    public void updateAirQualityHistory(int idHistory, double latitude, double longitude, String city, String state,
                                        String country, double temperatureCelsius, int humidityPercent, int airQualityAQI,
                                        String date) {
        try {
            String sqlUpdate = "UPDATE AIR_QUALITY_HISTORY SET LATITUDE = ?, LONGITUDE = ?, CITY = ?, STATE = ?, " +
                    "COUNTRY = ?, TEMPERATURECELSIUS = ?, HUMIDITYPERCENT = ?, AIRQUALITYAQI = ?, DATE = ? " +
                    "WHERE IDHISTORY = ?";
            PreparedStatement stm = connection.prepareStatement(sqlUpdate);
            stm.setDouble(1, latitude);
            stm.setDouble(2, longitude);
            stm.setString(3, city);
            stm.setString(4, state);
            stm.setString(5, country);
            stm.setDouble(6, temperatureCelsius);
            stm.setInt(7, humidityPercent);
            stm.setInt(8, airQualityAQI);
            stm.setString(9, date);
            stm.setInt(10, idHistory);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e + " Warning: no data updated");
        }
    }

    public void insertAirQualityHistory(double latitude, double longitude, String city, String state,
                                        String country, double temperatureCelsius, int humidityPercent, int airQualityAQI,
                                        String date) {

        try{
        String query = "SELECT * FROM AIR_QUALITY_HISTORY WHERE latitude = ? AND longitude = ? AND date = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setDouble(1, latitude);
            stm.setDouble(2, longitude);
            stm.setString(3, date);
            ResultSet result = stm.executeQuery();
            if(!result.next()) {
                String sqlInsert = "INSERT INTO AIR_QUALITY_HISTORY (LATITUDE, LONGITUDE, CITY, STATE, COUNTRY, TEMPERATURECELSIUS, HUMIDITYPERCENT, AIRQUALITYAQI, DATE) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stm2 = connection.prepareStatement(sqlInsert);
                stm2.setDouble(1, latitude);
                stm2.setDouble(2, longitude);
                stm2.setString(3, city);
                stm2.setString(4, state);
                stm2.setString(5, country);
                stm2.setDouble(6, temperatureCelsius);
                stm2.setInt(7, humidityPercent);
                stm2.setInt(8, airQualityAQI);
                stm2.setString(9, date);
                stm2.executeUpdate();
            }} catch (SQLException e) {
            System.out.println(e + " Warning: no data updated");
        }
    }

}
