require File.dirname(__FILE__) + '/../test_helper'
require 'manage_controller'

# Re-raise errors caught by the controller.
class ManageController; def rescue_action(e) raise e end; end

class ManageControllerTest < Test::Unit::TestCase
  fixtures :poems

  def setup
    @controller = ManageController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = poems(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:poems)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:poem)
    assert assigns(:poem).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:poem)
  end

  def test_create
    num_poems = Poem.count

    post :create, :poem => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_poems + 1, Poem.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:poem)
    assert assigns(:poem).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Poem.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Poem.find(@first_id)
    }
  end
end
