require "test_helper"

class AvailabilityTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test4@example.com", role: "partner", password: "password")
    @availability = Availability.new(user: @user, start_time: 1.hour.from_now, end_time: 2.hours.from_now)
  end

  test "should be valid with valid attributes" do
    assert @availability.valid?
  end

  test "should require start_time and end_time" do
    @availability.start_time = nil
    assert_not @availability.valid?
    @availability.start_time = 1.hour.from_now
    @availability.end_time = nil
    assert_not @availability.valid?
  end

  test "end_time should be after start_time" do
    @availability.end_time = @availability.start_time - 1.minute
    assert_not @availability.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
