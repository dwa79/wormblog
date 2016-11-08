require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
    def setup
       @category = Category.create(name:"hellow") 
    end
    test "shall get categories index" do
        get :index
        assert_response :success
    end
    
    test "shall get new" do
        get :new
        assert_response :success
    end
    
    test "shall get show" do
        get(:show, {'id' => @category.id})
        assert_response :success
        
    end
end