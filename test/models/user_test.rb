require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "test@example.com", role: "client", password: "password")
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "role should be present and valid" do
    @user.role = ""
    assert_not @user.valid?
    @user.role = "invalid"
    assert_not @user.valid?
    @user.role = "client"
    assert @user.valid?
  end

  test "active_subscription? returns true only for active subscription" do
    @user.build_subscription(status: "active", end_date: 1.day.from_now, start_date: Time.current)
    assert @user.active_subscription?
    @user.subscription.status = "inactive"
    assert_not @user.active_subscription?
    @user.subscription.status = "active"
    @user.subscription.end_date = 1.day.ago
    assert_not @user.active_subscription?
  end
end
