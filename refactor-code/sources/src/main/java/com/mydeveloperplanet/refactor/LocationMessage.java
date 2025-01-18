package com.mydeveloperplanet.refactor;

import org.geojson.GeoJsonObject;

public class LocationMessage extends BaseMessage {

    private GeoJsonObject geoJson;

    public GeoJsonObject getGeoJson() {
        return geoJson;
    }

    public void setGeoJson(GeoJsonObject geoJson) {
        this.geoJson = geoJson;
    }
}
