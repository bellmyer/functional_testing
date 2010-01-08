def class_name
  test_unit_class.name.gsub(/ControllerTest$/, '').downcase
end

def should_display(template)
  should_respond_with :success
  should_render_with_layout class_name.to_sym
  should_render_template template
  should_not_set_the_flash
end

def should_not_authorize(action)
  name = class_name
  
  context "attempting to #{action}" do
    setup do
      eval action
    end
    
    should_not_assign_to name.to_sym
    should_not_assign_to name.singularize.to_sym
    should_respond_with 401
    should_render_without_layout
    should_not_set_the_flash
  end
end

def should_require_login_for(action)
  name = class_name

  context "attempting to #{action}" do
    setup do
      eval action
    end

    should_not_assign_to name.to_sym
    should_not_assign_to name.singularize.to_sym
    should_redirect_to("login"){new_session_path}
    should_set_the_flash_to 'You need to login to do this.'
  end
end

