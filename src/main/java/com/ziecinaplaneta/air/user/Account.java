package com.ziecinaplaneta.air.user;

public class Account {

    private String login = "";
    private String imie = "";
    private String email = "";
    private int wiek = 0;
    private int uprawnienia = 0;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdRegion() {
        return idRegion;
    }

    public void setIdRegion(int idRegion) {
        this.idRegion = idRegion;
    }

    private int id;
    private int idRegion;

    public String getImie() {
        return imie;
    }

    public void setImie(String imie) {
        this.imie = imie;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public int getWiek() {
        return wiek;
    }

    public void setWiek(int wiek) {
        this.wiek = wiek;
    }
// -1 niezalogowany
// 1 zalogowany
// 2 administrator

    public String getLogin(){
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public void setUprawnienia(int uprawnienia) {
        this.uprawnienia = uprawnienia;
    }

    public int getUprawnienia() {
        return uprawnienia;
    }

    @Override
    public String toString() {
        return "MZuzytkownik{" +
                "login='" + login + '\'' +
                ", uprawnienia=" + uprawnienia +
                '}';
    }

}
