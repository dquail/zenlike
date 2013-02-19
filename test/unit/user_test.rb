require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def new_user(email) 
    User.new(email: email, password: "test")
  end
  
  test "user attributes must not be empty" do user = User.new
    assert user.invalid?

    assert user.errors[:email].any?
    assert user.errors[:password].any?
  end
  
  test "user email format" do user = User.new
    ok = %w{ fred@hotmail.com dustin.ho@test.microsoft.com test@me.me }
    bad = %w{ fred@test @test tom@me.com/do john }
    ok.each do |name|
      assert new_user(name).valid?, "#{name} shouldn't be invalid"
    end
    bad.each do |name|
      assert new_user(name).invalid?, "#{name} shouldn't be valid"
    end
  end
end
