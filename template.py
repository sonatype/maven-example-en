import airspeed
import glob
import os

t = airspeed.Template(open("site/book-template.html", "r").read())
bookTitle = "Maven by Example"
bookId = "ss-book-mvnex"
path = 'target/site/reference'
for infile in glob.glob( os.path.join(path, '*.html') ):
  print "Reading File: " + infile
  body = open(infile, "r").read()
  title = body[ body.index( "<title>" ) + 7 : body.rindex("</title>") ]
  body = body[ body.index( "<body>") + 6 : body.rindex("</body>") ]

  if "index.html" in infile:
    print ("Replacing bookTitle  - replacing with ToC" )
    title = "Table of Contents"
    body = body.replace(bookTitle, title)
    
  open(infile, "w").write( t.merge(locals()) );
  

