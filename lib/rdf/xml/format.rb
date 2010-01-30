module RDF::XML
  ##
  # Turtle format specification.
  # FIXME docs
  class Format < RDF::Format
    content_type 'application/rdf+xml', :extension => :rdf
    content_encoding 'UTF-8'
 
    reader { RDF::XML::Reader }
    writer { RDF::XML::Writer }
  end
end

