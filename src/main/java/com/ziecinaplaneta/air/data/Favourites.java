package com.ziecinaplaneta.air.data;

import com.ziecinaplaneta.air.database.Driver;

public class Favourites {

    boolean[] regions = new boolean[10];
    int idUser;

    public Favourites(int idUser) {
        this.idUser = idUser;
        Driver database = new Driver();
        this.regions = database.getFavouritesRegions(idUser);
    }

    public boolean[] getRegions() {
        return regions;
    }

    public void setRegions(boolean[] regions) {
        this.regions = regions;
    }

    public boolean saveFavourites() {
        Driver database = new Driver();
        return database.setFavouritesRegions(regions, idUser);
    }
}
