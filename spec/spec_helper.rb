
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..','/lib')))
# development version of rdf, if available
#$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '../' '../', 'rdf', 'lib' )))
require 'rdf'
require 'rdf/xml'
require 'rdf/ntriples'
require 'rdf/isomorphic'
module RDF
  module Isomorphic
    alias_method :==, :isomorphic_with?
  end
end

