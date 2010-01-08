def class_name
  test_unit_class.name.gsub(/ControllerTest$/, '').downcase
end

def actify(action)
  case action
    when :index then 'get :index'
    when :show  then 'get :show'
    when :new   then 'get :new'
    when :create  then 'post :create'
    when :edit    then 'get :edit'
    when :update  then 'put :update'
    when :destroy then 'put :destroy'
    else (action.is_a?(Symbol) ? "get :#{action}" : action)
  end
end

def should_display(template)
  should_respond_with :success
  should_render_with_layout class_name.to_sym
  should_render_template template
  should_not_set_the_flash
end

def should_not_authorize(*actions)
  actions = [:index, :show, :new, :create, :edit, :update, :destroy] if actions == [:all]
  name = class_name
  
  actions.each do |action|
    context "attempting to #{action}" do
      setup do
        eval actify(action)
      end
      
      should_not_assign_to name.to_sym
      should_not_assign_to name.singularize.to_sym
      should_respond_with 401
      should_render_without_layout
      should_not_set_the_flash
    end
  end
end

def should_require_login_for(*actions)
  actions = [:index, :show, :new, :create, :edit, :update, :destroy] if actions == [:all]
  name = class_name

  actions.each do |action|
    context "attempting to #{action}" do
      setup do
        eval actify(action)
      end

      should_not_assign_to name.to_sym
      should_not_assign_to name.singularize.to_sym
      should_redirect_to("login"){new_session_path}
      should_set_the_flash_to 'You need to login to do this.'
    end
  end
end

