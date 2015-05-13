import airspeed
import glob
import os
import argparse

parser = argparse.ArgumentParser(description='Script to wrap produces html into template for site deployment')
parser.add_argument('-l','--laf',help='Path to the template html file providing the look and feel', required=True)

args = parser.parse_args()
laf = args.laf

if not laf:
  laf = "site/book-template.html"

t = airspeed.Template(open(laf, "r").read())
bookTitle = "Maven by Example"
path = 'target/site/reference'
for infile in glob.glob( os.path.join(path, '*.html') ):
  if infile.endswith( 'search.html'):
    print( "  Ignoring search.html" )
  elif infile.endswith( 'template.html'):
    print( "  Ignoring template.html" )
  else:
  
    print "Reading File: " + infile
    body = open(infile, "r").read()
    title = body[ body.index( "<title>" ) + 7 : body.rindex("</title>") ]
    body = body[ body.index( "<body>") + 6 : body.rindex("</body>") ]
  
    if "index.html" in infile:
      print ("Replacing bookTitle  - replacing with ToC" )
      title = "Table of Contents"
      body = body.replace(bookTitle, title)
      
    open(infile, "w").write( t.merge(locals()) );

