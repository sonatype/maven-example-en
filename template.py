import airspeed
import glob
import os

t = airspeed.Template(open("site/book-template.html", "r").read())
bookTitle = "Maven by Example"
bookId = "mvnexbook"
 
path = 'target/site/reference'
for infile in glob.glob( os.path.join(path, '*.html') ):
  body = open(infile, "r").read()
  body = body[ body.index( "<body>") + 6 : body.rindex("</body>") ]
  title = "Maven by Example"
  open(infile, "w").write( t.merge(locals()) );
