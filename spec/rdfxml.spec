require File.join(File.dirname(__FILE__), 'spec_helper')

tests = {}
[:positive_parser_tests,:negative_parser_tests,:warn_parser_tests].each do |group|
  group_dirs = Dir.glob(File.join(File.dirname(__FILE__),"tests",group.to_s, '/*')).sort
  #puts "group dirs: #{group_dirs}"
  subgroups = group_dirs.map { | dir | File.basename(dir) }
  tests[group] = {}
  subgroups.each do | subgroup |
    tests[group][subgroup] = {}
    #puts "checking out #{subgroup}"
    test_files = Dir.glob(File.join(File.dirname(__FILE__), "tests", group.to_s, subgroup, "*.rdf"))
    test_files.each do | testfile |
      #puts "checking out #{testfile}"
      resultfile = testfile.sub(/\.rdf$/,".nt")
      tests[group][subgroup][testfile] = resultfile
    end
  end
end

puts "test keys: #{tests.keys}"

tests.each do | group , value |
  puts "group: #{group.class} value: #{tests[group].class}"
end

describe RDF::XML do


  context "after load" do

    it "should be an available format" do
      RDF::Format.each.should include RDF::XML::Format
    end

    it "should be the format for .rdf files" do
      RDF::Format.for('sample.rdf').should == RDF::XML::Format
    end

    it "should be the format for :xml " do
      RDF::Format.for(:xml).should == RDF::XML::Format
    end

    it "should have RDF::XML::Reader as its reader" do
      RDF::XML::Format.reader.should == RDF::XML::Reader
    end

    it "should have RDF::XML::Writer as its writer" do
      RDF::XML::Format.writer.should == RDF::XML::Writer
    end

    it "should be an available reader" do
      RDF::Reader.each.should include RDF::XML::Reader
    end

    it "should be defined as the reader for .rdf files" do
      RDF::Reader.for('sample.rdf').should == RDF::XML::Reader
    end

    it "should be defined as the reader for :xml files" do
      RDF::Reader.for(:xml).should == RDF::XML::Reader
    end
  end

  context "when parsing" do
    context "invalid files" do
      tests[:negative_parser_tests].each do | subgroup, subtests |
        context "from w3c test case #{subgroup}" do
          subtests.each do | sourcefile, resultfile |
            it "should fail to parse #{File.basename(sourcefile)}" do
              lambda {rdfxml = RDF::Repository.load(sourcefile)}.should raise_error RDF::ReaderError
            end
          end
        end
      end
    end

    context "valid files" do
      tests[:positive_parser_tests].each do | subgroup, subtests |
        context "from w3c test case #{subgroup}" do
          subtests.each do | sourcefile, resultfile |
            it "should successfully parse #{File.basename(sourcefile)}" do
              rdfxml = RDF::Repository.load(sourcefile)
              puts rdfxml.inspect unless rdfxml.empty?
              ntriples = RDF::Repository.load(resultfile)
              rdfxml.should have_the_same_triples_as ntriples
            end
          end
        end
      end
    end

    context "files that produce warnings" do
      tests[:warn_parser_tests].each do | subgroup, subtests |
        context "from w3c test case #{subgroup}" do
          subtests.each do | sourcefile, resultfile |
            it "should successfully parse #{File.basename(sourcefile)} but throw a warning" do
              pending "decide on what rdf.rb should do for warnings"
            end
          end
        end
      end
    end
  end



  context "when serializing" do

  end


end
