require 'nokogiri'

module RDF::XML
  ##
  # XML parser.
  # FIXME doc me up
  class Reader < RDF::Reader
    format RDF::XML::Format


    ##
    # @return [Array, nil]
    # # FIXME docs
    def read_triple
      parsed = parsed_triples.next
      puts "returning #{parsed}"
      parsed
      #parsed_triples.next 
    end

    def parsed_triples
      unless @parsed_repository
        parse_input
        @triples = @parsed_repository.each_triple
      end
      @triples
    end

    def parse_input
      @document = Nokogiri::XML.parse @input
      raise RDF::ReaderError, @document.errors.inspect unless @document.errors.empty?
      repository = RDF::Repository.new
      prefixes = {}
      @document.collect_namespaces.each do | namespace, uri |
        prefixes[namespace.sub('xmlns:','')] = uri
      end

      elements = @document.root.children.to_a.find_all do | item | 
        item.class == Nokogiri::XML::Element 
      end
      
      elements.each do | element |
        next unless element.attributes.has_key? 'about'
        resource = element.attributes['about'].value
        if element.name != 'Description'
          repository.insert([ RDF::URI.new(resource),
                              RDF.type,
                              RDF::URI.new(element.namespace.href + element.name)])
          puts "inserted an RDF.type! #{repository.inspect}"
        end
        #children.first.namespace.href + children.first.name

      end
      @parsed_repository = repository
    end

  end
end
 

