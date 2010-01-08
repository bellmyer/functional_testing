require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  fixtures :users, :roles, :roles_users
  
  context "as admin" do
    setup do
      @setting = Factory.build :setting
      @setting.id = 1001

      Setting.stubs(:find).returns(@setting)
      Setting.stubs(:find).with(:all, anything).returns([@setting])
      
      login_as :admin
    end
    
    context "getting index" do
      setup do
        get :index
      end
      
      should_assign_to(:settings){[@setting]}
      should_respond_with :success
      should_render_with_layout :settings
      should_render_template :index
      should_not_set_the_flash
    end
    
    context "getting show" do
      setup do
        get :show, :id => @setting.id
      end
      
      should_assign_to(:setting){@setting}
      should_respond_with :success
      should_render_with_layout :settings
      should_render_template :show
      should_not_set_the_flash
    end
    
    context "getting new" do
      setup do
        get :new
      end
      
      should_assign_to :setting, :class => Setting
      should_respond_with :success
      should_render_with_layout :settings
      should_render_template :new
      should_not_set_the_flash
    end
    
    context "posting create" do
      context "with valid data" do
        setup do
          Setting.any_instance.expects(:save).returns(true).once
          Setting.any_instance.stubs(:id).returns(1001)
          
          post :create, :setting => {}
        end
        
        should_assign_to :setting, :class => Setting
        should_redirect_to("setting page"){setting_path(1001)}
        should_set_the_flash_to "Setting was successfully created."
      end
      
      context "with invalid data" do
        setup do
          Setting.any_instance.expects(:save).returns(false).once
          post :create, :setting => {}
        end
        
        should_assign_to :setting, :class => Setting
        should_respond_with :success
        should_render_with_layout :settings
        should_render_template :new
        should_not_set_the_flash
      end
    end

    context "getting edit" do
      setup do
        get :edit, :id => @setting.id
      end
      
      should_assign_to(:setting){@setting}
      should_respond_with :success
      should_render_with_layout :settings
      should_render_template :edit
      should_not_set_the_flash
    end

    context "updating" do
      context "with valid data" do
        setup do
          @setting.expects(:update_attributes).returns(true).once
          put :update, :id => @setting.id, :setting => {}
        end
        
        should_assign_to(:setting){@setting}
        should_redirect_to("setting page"){setting_path(1001)}
        should_set_the_flash_to "Setting was successfully updated."
      end
      
      context "with invalid data" do
        setup do
          @setting.expects(:update_attributes).returns(false).once
          put :update, :id => @setting.id, :setting => {}
        end
        
        should_assign_to :setting, :class => Setting
        should_respond_with :success
        should_render_with_layout :settings
        should_render_template :edit
        should_not_set_the_flash
      end
    end
    
    context "destroying" do
      setup do
        @setting.expects(:destroy).once
        delete :destroy, :id => @setting.id
      end
      
      should_assign_to(:setting){@setting}
      should_redirect_to("index"){settings_path}
      should_not_set_the_flash
    end
  end
  
  context "as a member" do
    setup do
      login_as :quentin
    end
    
    context "attempting to get index" do
      setup do
        get :index
      end
      
      should_not_assign_to :settings
      should_respond_with 401
      should_render_without_layout
      should_not_set_the_flash
    end

    context "attempting to get show" do
      setup do
        get :show
      end
      
      should_not_assign_to :setting
      should_respond_with 401
      should_render_without_layout
      should_not_set_the_flash
    end

    context "attempting to get new" do
      setup do
        get :new
      end
      
      should_not_assign_to :setting
      should_respond_with 401
      should_render_without_layout
      should_not_set_the_flash
    end

    context "attempting to post create" do
      setup do
        post :create
      end
      
      should_not_assign_to :setting
      should_respond_with 401
      should_render_without_layout
      should_not_set_the_flash
    end

    context "attempting to get edit" do
      setup do
        get :edit
      end
      
      should_not_assign_to :setting
      should_respond_with 401
      should_render_without_layout
      should_not_set_the_flash
    end

    context "attempting to update" do
      setup do
        put :update
      end
      
      should_not_assign_to :setting
      should_respond_with 401
      should_render_without_layout
      should_not_set_the_flash
    end

    context "attempting to destroy" do
      setup do
        delete :destroy
      end
      
      should_not_assign_to :setting
      should_respond_with 401
      should_render_without_layout
      should_not_set_the_flash
    end
  end
  
  context "as a visitor" do
    context "attempting to get index" do
      setup do
        get :index
      end
      
      should_not_assign_to :settings
      should_redirect_to("login"){new_session_path}
      should_set_the_flash_to 'You need to login to do this.'
    end

    context "attempting to get show" do
      setup do
        get :show
      end
      
      should_not_assign_to :setting
      should_redirect_to("login"){new_session_path}
      should_set_the_flash_to 'You need to login to do this.'
    end

    context "attempting to get new" do
      setup do
        get :new
      end
      
      should_not_assign_to :setting
      should_redirect_to("login"){new_session_path}
      should_set_the_flash_to 'You need to login to do this.'
    end

    context "attempting to post create" do
      setup do
        post :create
      end
      
      should_not_assign_to :setting
      should_redirect_to("login"){new_session_path}
      should_set_the_flash_to 'You need to login to do this.'
    end

    context "attempting to get edit" do
      setup do
        get :edit
      end
      
      should_not_assign_to :setting
      should_redirect_to("login"){new_session_path}
      should_set_the_flash_to 'You need to login to do this.'
    end

    context "attempting to update" do
      setup do
        put :update
      end
      
      should_not_assign_to :setting
      should_redirect_to("login"){new_session_path}
      should_set_the_flash_to 'You need to login to do this.'
    end

    context "attempting to destroy" do
      setup do
        delete :destroy
      end
      
      should_not_assign_to :setting
      should_redirect_to("login"){new_session_path}
      should_set_the_flash_to 'You need to login to do this.'
    end
  end
end
