package org.sonatype.book;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.Reader;
import java.io.StringWriter;

import org.apache.commons.io.IOUtils;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

public class VelocityMerger {
	
	private File velocityTemplate;
	
	public VelocityMerger(File velocityTemplate) {
		this.velocityTemplate = velocityTemplate;
	}
	
	public void mergeFile( File htmlFile, SiteMeshPageExtractor extractor ) throws Exception {

		
		Velocity.init();
		
		VelocityContext context = new VelocityContext();
		context.put( "title", extractor.getProperties().get("title") );
		context.put( "head", extractor.getHead() );
		context.put( "body", extractor.getBody() );
		
		Reader template = new FileReader( velocityTemplate );
		
		StringWriter writer = new StringWriter();
		
		Velocity.evaluate( context, writer, "MERGE", template );
		
		FileWriter output = new FileWriter( htmlFile );
		IOUtils.write( writer.toString(), output );
		output.close();
	}

}
