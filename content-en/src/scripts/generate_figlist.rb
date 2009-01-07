require 'rexml/document'
require 'rexml/xpath'

include REXML

xml_data = File.new(ARGV[0])
chapter = ARGV[1]

doc = REXML::Document.new(xml_data)
figures = []
doc.elements.each('//figure') do |ele|
   figures << ele
end

# print all figures
figures.each_with_index do |figure, idx|
   print "#{chapter}.#{idx + 1} | #{figure.elements[1].text} | #{XPath.first( figure, "//@fileref" )}\n"
end
