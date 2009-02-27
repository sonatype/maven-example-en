package org.sonatype.book;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.Collection;

import org.apache.commons.io.DirectoryWalker;
import org.apache.commons.io.filefilter.IOFileFilter;

public class ContentHandler extends DirectoryWalker {

	private VelocityMerger velocityMerger;
	
	public ContentHandler(IOFileFilter directoryFilter,
			IOFileFilter fileFilter, int depthLimit, VelocityMerger vMerger) {
		super(directoryFilter, fileFilter, depthLimit);
		this.velocityMerger = vMerger;
	}



	@Override
	protected boolean handleDirectory(File directory, int depth,
			Collection results) throws IOException {
		System.out.println( "WHOP: " + directory.getAbsolutePath() );
		
		return true;
	}



	@Override
	protected void handleFile(File file, int depth, Collection results)
			throws IOException {
		System.out.println("File: " + file.getAbsolutePath());
		
		SiteMeshPageExtractor extractor = new SiteMeshPageExtractor();
		extractor.parse( file );
		
		try {
			velocityMerger.mergeFile( file, extractor );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void go(File dir, Collection results) throws IOException {
		walk( dir, results);
	}
}
