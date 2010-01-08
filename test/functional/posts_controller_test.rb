require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  fixtures :users, :roles, :roles_users

  context "as admin" do
    setup do
      @post = Factory.build :post
      @post.id = 1001

      Post.stubs(:find).returns(@post)
      Post.stubs(:find).with(:all, anything).returns([@post])
      
      login_as :admin
    end
    
    context "getting index" do
      setup do
        get :index
      end
      
      should_assign_to(:posts){[@post]}
      should_display :index
    end
    
    context "getting show" do
      setup do
        get :show, :id => @post.id
      end
      
      should_assign_to(:post){@post}
      should_display :show
    end
    
    context "getting new" do
      setup do
        get :new
      end
      
      should_assign_to :post, :class => Post
      should_display :new
    end
    
    context "posting create" do
      context "with valid data" do
        setup do
          Post.any_instance.expects(:save).returns(true).once
          Post.any_instance.stubs(:id).returns(1001)
          
          post :create, :post => {}
        end
        
        should_assign_to :post, :class => Post
        should_redirect_to("post page"){post_path(1001)}
        should_set_the_flash_to "Post was successfully created."
      end
      
      context "with invalid data" do
        setup do
          Post.any_instance.expects(:save).returns(false).once
          post :create, :post => {}
        end
        
        should_assign_to :post, :class => Post
        should_display :new
      end
    end

    context "getting edit" do
      setup do
        get :edit, :id => @post.id
      end
      
      should_assign_to(:post){@post}
      should_display :edit
    end

    context "updating" do
      context "with valid data" do
        setup do
          @post.expects(:update_attributes).returns(true).once
          put :update, :id => @post.id, :post => {}
        end
        
        should_assign_to(:post){@post}
        should_redirect_to("post page"){post_path(1001)}
        should_set_the_flash_to "Post was successfully updated."
      end
      
      context "with invalid data" do
        setup do
          @post.expects(:update_attributes).returns(false).once
          put :update, :id => @post.id, :post => {}
        end
        
        should_assign_to :post, :class => Post
        should_display :edit
      end
    end
    
    context "destroying" do
      setup do
        @post.expects(:destroy).once
        delete :destroy, :id => @post.id
      end
      
      should_assign_to(:post){@post}
      should_redirect_to("index"){posts_path}
      should_not_set_the_flash
    end
  end
  
  context "as a member" do
    setup do
      login_as :quentin
    end
  
    should_not_authorize :all
  end
  
  context "as a visitor" do
    should_require_login_for :all
  end
end
