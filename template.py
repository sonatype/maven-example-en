import airspeed
import glob
import os

t = airspeed.Template(open("site/book-template.html", "r").read())
bookTitle = "Maven by Example"
bookId = "ss-book-mvnex"
replaceTitleWithToC = None

path = 'target/site/reference'
for infile in glob.glob( os.path.join(path, '*.html') ):
  print "Reading File: " + infile
  body = open(infile, "r").read()
  title = body[ body.index( "<title>" ) + 7 : body.rindex("</title>") ]

  if title == "Maven by Example":
    title = "Table of Contents"
    replaceTitleWithToC = True 

  body = body[ body.index( "<body>") + 6 : body.rindex("</body>") ]

  if replaceTitleWithToC:
    h1Title = "<h1 class=\"title\">"
    h1Close = "</h1>"
    if h1Title in body:
      titleInBody = body[body.index(h1Title) : body.rindex(h1Close) + len(h1Close)]
      print ("Found title in body: %s " % titleInBody)
      body = body.replace(bookTitle, "Table of Contents", 1)
      
  open(infile, "w").write( t.merge(locals()) );

