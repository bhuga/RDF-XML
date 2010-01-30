
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..','/lib')))
# development version of rdf, if available
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '../' '../', 'rdf', 'lib' )))
require 'rdf'
require 'rdf/xml'

Spec::Matchers.define :have_the_same_triples_as do |expected_repository|
  match do |actual_repository|
    expected_statements = []
    expected_count = 0
    expected_repository.each do |statement|
      expected_statements << statement
      expected_count += 1
    end
    actual_count = 0
    actual_repository.each do | statement |
      expected_statements.should include statement
      actual_count += 1
    end
    actual_count.should == expected_count
  end
end


