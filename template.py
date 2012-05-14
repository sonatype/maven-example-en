import airspeed
import glob
import os

t = airspeed.Template(open("site/book-template.html", "r").read())
bookTitle = "Maven by Example"
bookId = "mvnexbook"
 
path = 'target/site/reference'
for infile in glob.glob( os.path.join(path, '*.html') ):
  print "Reading File: " + infile
  body = open(infile, "r").read()
  title = body[ body.index( "<title>" ) + 7 : body.rindex("</title>") ]

  if title == "Maven by Example":
    title = "Table of Contents"

  body = body[ body.index( "<body>") + 6 : body.rindex("</body>") ]
  
  open(infile, "w").write( t.merge(locals()) );

