package org.sonatype.mavenbook.weather.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

@Entity
public class Atmosphere {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Integer id;

    private String humidity;
    private String visibility;
    private String pressure;
    private String rising;
    
    @OneToOne(cascade=CascadeType.ALL)
    @JoinColumn(name="weather_id", nullable=false)
    private Weather weather;

    public Atmosphere() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public final String getHumidity() {	return humidity; }
    public final void setHumidity(final String newHumidity) {
	this.humidity = newHumidity;
    }

    public final String getVisibility() { return visibility; }
    public final void setVisibility(final String newVisibility) {
	this.visibility = newVisibility;
    }

    public final String getPressure() { return pressure; }
    public final void setPressure(final String newPressure) {
	this.pressure = newPressure;
    }

    public final String getRising() { return rising; }
    public final void setRising(final String newRising) {
	this.rising = newRising;
    }
    
    public Weather getWeather() { return weather; }
    public void setWeather(Weather weather) { this.weather = weather; }
    
}