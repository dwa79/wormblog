require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
   def setup
      @category = Category.new(name: "sports") 
   end
   
   test "category shall be valid" do
       assert @category.valid?
   end
   
   test "name shall be valid" do
      @category.name = " "
      assert_not @category.valid?
   end
   
   test "name shall be unique" do
      @category.save
      category2 = Category.new(name:"sports")
      assert_not category2.valid?
   end
   
   test "name shall not be too long" do 
       @category.name = "a" * 29
       assert_not @category.valid?
   end
   
   test "name shall not be too short" do
      @category.name  = "xa"
      assert_not @category.valid?
   end
end