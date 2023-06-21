package com.ziecinaplaneta.air.data;

import com.ziecinaplaneta.air.database.Driver;

public class Favourites {

    boolean[] regions = new boolean[10];

    public Favourites(int idUser) {
        Driver database = new Driver();
        this.regions = database.getFavouritesTegions(idUser);
    }

    public boolean[] getRegions() {
        return regions;
    }

    public void setRegions(boolean[] regions) {
        this.regions = regions;
    }

    public boolean saveFavourites(boolean[] regions, int idUser) {
        Driver database = new Driver();
        return database.setFavouritesRegions(regions, idUser);
    }
}
