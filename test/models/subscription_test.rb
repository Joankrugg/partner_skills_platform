require "test_helper"

class SubscriptionTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test2@example.com", role: "client", password: "password")
    @subscription = Subscription.new(user: @user, start_date: Date.today, end_date: Date.tomorrow, status: "active")
  end

  test "should be valid with valid attributes" do
    assert @subscription.valid?
  end

  test "should require start_date, end_date, and status" do
    @subscription.start_date = nil
    assert_not @subscription.valid?
    @subscription.start_date = Date.today
    @subscription.end_date = nil
    assert_not @subscription.valid?
    @subscription.end_date = Date.tomorrow
    @subscription.status = nil
    assert_not @subscription.valid?
  end

  test "status should be in allowed values" do
    @subscription.status = "invalid"
    assert_not @subscription.valid?
    @subscription.status = "active"
    assert @subscription.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
