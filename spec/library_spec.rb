require 'spec_helper'

describe "Library Object" do

    before :all do
        lib_arr = [
            Book.new("Mastery", "Robert Greene", :self_help),
            Book.new("The Alabaster Girl", "Zan Perrion", :relationships),
            Book.new("Conversations With God", "Neale Donald Walsch", :spirituality),
            Book.new("The Pragmatic Programmer", "Andrew Hunt", :development),
            Book.new("Way of the Peaceful Warrior", "Dan Millman", :spirituality),
         ]

        File.open "books.yml", "w" do |f|
            f.write YAML::dump lib_arr
        end
     end

    before :each do
        @lib = Library.new "books.yml"
    end

    describe "#new" do
        context "with no parameters" do
           it "has no books" do
               lib = Library.new
               lib.books.length.should == 0
           end
        end

        context "with a yaml file name parameter" do
            it "has five books" do
                @lib.books.length.should == 5
            end
        end
    end

    it "returns all the books in a given category" do
        @lib.get_books_in_category(:spirituality).length.should == 2
    end

    it "accepts new books" do
        @lib.add_book( Book.new("Siddhartha", "Herman Hesse", :philosophical_fiction))
        @lib.get_book("Siddhartha").should be_an_instance_of Book
    end

    it "saves the library" do
        books = @lib.books.map { |book| book.title }
        @lib.save "our_new_library.yml"
        lib2 = Library.new "our_new_library.yml"
        books2 = lib2.books.map { |book| book.title }
        books.should eq books2
    end

end
