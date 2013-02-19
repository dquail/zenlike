require 'test_helper'

class MeetingThreadsControllerTest < ActionController::TestCase
  setup do
    @meeting_thread = meeting_threads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meeting_threads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting_thread" do
    assert_difference('MeetingThread.count') do
      post :create, meeting_thread: { attachmen_count: @meeting_thread.attachmen_count, cc: @meeting_thread.cc, from: @meeting_thread.from, headers: @meeting_thread.headers, html: @meeting_thread.html, subject: @meeting_thread.subject, text: @meeting_thread.text, to: @meeting_thread.to, user_id: @meeting_thread.user_id }
    end

    assert_redirected_to meeting_thread_path(assigns(:meeting_thread))
  end

  test "should show meeting_thread" do
    get :show, id: @meeting_thread
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meeting_thread
    assert_response :success
  end

  test "should update meeting_thread" do
    put :update, id: @meeting_thread, meeting_thread: { attachmen_count: @meeting_thread.attachmen_count, cc: @meeting_thread.cc, from: @meeting_thread.from, headers: @meeting_thread.headers, html: @meeting_thread.html, subject: @meeting_thread.subject, text: @meeting_thread.text, to: @meeting_thread.to, user_id: @meeting_thread.user_id }
    assert_redirected_to meeting_thread_path(assigns(:meeting_thread))
  end

  test "should destroy meeting_thread" do
    assert_difference('MeetingThread.count', -1) do
      delete :destroy, id: @meeting_thread
    end

    assert_redirected_to meeting_threads_path
  end
end
