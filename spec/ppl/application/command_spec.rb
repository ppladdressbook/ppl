
describe Ppl::Application::Command, "#execute" do

  before(:each) do
    @command = Ppl::Application::Command.new
  end

  it "should raise not implemented error" do
    expect{@command.execute(nil, nil)}.to raise_error(NotImplementedError)
  end

  it "should accept a storage adapter" do
    storage = double(Ppl::Adapter::Storage)
    @command.storage = storage
    @command.storage.should be storage
  end

  it "should allow new properties to be defined" do
    class TestCommand123 < Ppl::Application::Command
      add_property :some_property
    end
  end

  it "should allow properties to have values assigned to them" do
    class TestCommand456 < Ppl::Application::Command
      add_property :some_property
      some_property "a value"
    end
    TestCommand456.some_property.should eq "a value"
  end

  it "should expose properties as instance variables too" do
    class TestCommand789 < Ppl::Application::Command
      add_property :some_property
      some_property "a value"
    end
    instance = TestCommand789.new
    instance.some_property.should eq "a value"
  end

  it "should allow properties to be overwritten by instance variables" do
    class TestCommand901 < Ppl::Application::Command
      add_property :some_property
      some_property "a value"
    end
    instance = TestCommand901.new
    instance.some_property = "different"
    instance.some_property.should eq "different"
  end

  it "should allow the name to be set as an instance variable" do
    @command.name = "testing"
    @command.name.should eq "testing"
  end

  it "should allow the description to be set as an instance variable" do
    @command.description = "testing"
    @command.description.should eq "testing"
  end

  it "should allow the name to be set as a class variable" do
    class TestCommand123 < Ppl::Application::Command
      name "new_for_test"
    end
    command = TestCommand123.new
    command.name.should eq "new_for_test"
  end

  it "should allow the description to be set as a class variable" do
    class TestCommand123 < Ppl::Application::Command
      description "desc_for_test"
    end
    command = TestCommand123.new
    command.description.should eq "desc_for_test"
  end

end
