package org.sonatype.mavenbook.weather;

import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

import org.sonatype.mavenbook.weather.model.Location;
import org.sonatype.mavenbook.weather.model.Weather;

public class WeatherFormatter {

	private static Logger log = Logger.getLogger(WeatherFormatter.class);

	public String formatWeather( Weather weather ) throws Exception {
		log.info( "Formatting Weather Data" );
		Reader reader = new InputStreamReader( getClass().getClassLoader().getResourceAsStream("weather.vm"));
		VelocityContext context = new VelocityContext();
		context.put("weather", weather );
		StringWriter writer = new StringWriter();
		Velocity.evaluate(context, writer, "", reader);
		return writer.toString();		
	}

	public String formatHistory( Location location, List<Weather> weathers ) throws Exception {
		log.info( "Formatting History Data" );
		Reader reader = new InputStreamReader( getClass().getClassLoader().getResourceAsStream("history.vm"));
		VelocityContext context = new VelocityContext();
		context.put("location", location );
		context.put("weathers", weathers );
		StringWriter writer = new StringWriter();
		Velocity.evaluate(context, writer, "", reader);
		return writer.toString();		
	}
}
