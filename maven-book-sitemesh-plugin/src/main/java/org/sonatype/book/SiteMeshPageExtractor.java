	package org.sonatype.book;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.io.FileUtils;

import com.opensymphony.module.sitemesh.html.BasicRule;
import com.opensymphony.module.sitemesh.html.HTMLProcessor;
import com.opensymphony.module.sitemesh.html.Tag;
import com.opensymphony.module.sitemesh.html.TagRule;
import com.opensymphony.module.sitemesh.html.TextFilter;
import com.opensymphony.module.sitemesh.html.rules.BodyTagRule;
import com.opensymphony.module.sitemesh.html.rules.HeadExtractingRule;
import com.opensymphony.module.sitemesh.html.rules.MetaTagRule;
import com.opensymphony.module.sitemesh.html.rules.PageBuilder;
import com.opensymphony.module.sitemesh.html.rules.TitleExtractingRule;
import com.opensymphony.module.sitemesh.html.util.CharArray;

/**
 * PageExtractor which extract page information from an HTML file using the SiteMesh library.
 *
 * @author Joe Walnes
 * @author J&ouml;rg Schaible
 */
public class SiteMeshPageExtractor
{
    private Properties properties;
    private String filename;
    private String head;
    private String body;
    private List links;
    private final TagRule[] rules;
    private final TextFilter[] filter;

    public SiteMeshPageExtractor()
    {
        rules = new TagRule[0];
        filter = new TextFilter[0];
        links = new ArrayList();
    }

    public void parse(File htmlFile) {
    	try {
			extractContentFromHTML( FileUtils.readFileToString( htmlFile ).toCharArray() );
		} catch (IOException e) {
			e.printStackTrace();
		}
    }

    private void extractContentFromHTML( char[] rawHTML ) throws IOException
    {
        // where to dump properties extracted from the page
        properties = new Properties();
        PageBuilder pageBuilder = new PageBuilder()
        {
            public void addProperty( String key, String value )
            {
                properties.setProperty( key, value );
            }
        };

        // buffers to hold head and body content
        CharArray headBuffer = new CharArray( 64 );
        CharArray bodyBuffer = new CharArray( 4096 );

        // setup rules for html processor
        HTMLProcessor htmlProcessor = new HTMLProcessor( rawHTML, bodyBuffer );
        htmlProcessor.addRule( new BodyTagRule( pageBuilder, bodyBuffer ) );
        htmlProcessor.addRule( new HeadExtractingRule( headBuffer ) );
        htmlProcessor.addRule( new TitleExtractingRule( pageBuilder ) );
        htmlProcessor.addRule( new MetaTagRule( pageBuilder ) );
        htmlProcessor.addRule( new LinkExtractingRule() );

        for ( int i = 0; i < rules.length; i++ )
        {
            htmlProcessor.addRule( rules[i] );
        }
        for ( int i = 0; i < filter.length; i++ )
        {
            htmlProcessor.addTextFilter( filter[i] );
        }

        // go!
        htmlProcessor.process();
        this.head = headBuffer.toString();
        this.body = bodyBuffer.toString();
    }

    public static class CannotParsePageException extends RuntimeException
    {
        public CannotParsePageException( Throwable cause )
        {
            super( cause );
        }
    }

    /** Rule for HTMLProcessor that records all <a href=""> links. */
    private class LinkExtractingRule extends BasicRule
    {

        public boolean shouldProcess( String tag )
        {
            return tag.equalsIgnoreCase( "a" );
        }

        public void process( Tag tag )
        {
            if ( tag.hasAttribute( "href", false ) )
            {
                links.add( tag.getAttributeValue( "href", false ) );
            }
            tag.writeTo( currentBuffer() );
        }
    }

	public Properties getProperties() {
		return properties;
	}

	public void setProperties(Properties properties) {
		this.properties = properties;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}
    
    

}
