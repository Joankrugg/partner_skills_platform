require "test_helper"

class ServiceTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test3@example.com", role: "partner", password: "password")
    @category = Category.create!(name: "Gardening")
    @service = Service.new(name: "Lawn Mowing", duration: 60, price: 20.0, user: @user, category: @category)
  end

  test "should be valid with valid attributes" do
    assert @service.valid?
  end

  test "should require name, duration, and price" do
    @service.name = ""
    assert_not @service.valid?
    @service.name = "Lawn Mowing"
    @service.duration = nil
    assert_not @service.valid?
    @service.duration = 60
    @service.price = nil
    assert_not @service.valid?
  end

  test "duration and price should be positive numbers" do
    @service.duration = 0
    assert_not @service.valid?
    @service.duration = 60
    @service.price = -1
    assert_not @service.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
