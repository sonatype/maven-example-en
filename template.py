import airspeed
import glob
import os

t = airspeed.Template(open("site/book-template.html", "r").read())
bookTitle = "Maven by Example"
bookId = "mvnrefbook"
 
path = 'target/site/reference'
for infile in glob.glob( os.path.join(path, '*.html') ):
  print "Reading File: " + infile
  body = open(infile, "r").read()
  title = body[ body.index( "<title>" ) + 7 : body.rindex("</title>") ]

  if title == "Maven by Example":
    title = "Table of Contents"

  body = body[ body.index( "<body>") + 6 : body.rindex("</body>") ]

  h1Title = "<h1 class=\"title\">"
  h1Close = "</h1>"
  if h1Title in body:
    titleInBody = body[body.index(h1Title) : body.rindex(h1Close) + len(h1Close)]
    print ("Found title in body: %s " % titleInBody)
    body = body.replace(bookTitle, "", 1)
    body = body.replace(title, "", 1)
    print ("Found bookTitle and wiped")
    
  open(infile, "w").write( t.merge(locals()) );

