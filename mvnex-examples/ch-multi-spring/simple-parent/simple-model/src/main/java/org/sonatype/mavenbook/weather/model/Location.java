package org.sonatype.mavenbook.weather.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

@Entity
@NamedQueries({
	@NamedQuery(name="Location.uniqueByZip", query="from Location l where l.zip = :zip")
})
public class Location {
    
    @Id
    private String zip;

    private String city;
    private String region;
    private String country;

    public Location() {}

    public String getZip() { return zip; }
    public void setZip(String zip) { this.zip = zip; }
    
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    
    public String getRegion() {	return region; }
    public void setRegion(String region) { this.region = region; }
    
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

}