module RDF::XML
  ##
  # XML serializer.
  # FIXME docs
  class Writer < RDF::Writer
    format RDF::NTriples::Format
 
    ##
    # @param [String] text
    # @return [void]
    def write_comment(text)
      raise NotImplementedError
      puts "# #{text}"
    end
 
    ##
    # @param [Resource] subject
    # @param [URI] predicate
    # @param [Value] object
    # @return [void]
    def write_triple(subject, predicate, object)
      raise NotImplementedError
      puts "%s %s %s ." % [subject, predicate, object].map { |value| format_value(value) }
    end
 
  end
end
 

