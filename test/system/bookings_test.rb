require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase
  setup do
    @booking = bookings(:one)
  end

  test "visiting the index" do
    visit bookings_url
    assert_selector "h1", text: "Bookings"
  end

  test "should create booking" do
    visit bookings_url
    click_on "New booking"

    fill_in "Scheduled time", with: @booking.scheduled_time
    fill_in "Service", with: @booking.service_id
    fill_in "Status", with: @booking.status
    fill_in "User", with: @booking.user_id
    click_on "Create Booking"

    assert_text "Booking was successfully created"
    click_on "Back"
  end

  test "should update Booking" do
    visit booking_url(@booking)
    click_on "Edit this booking", match: :first

    fill_in "Scheduled time", with: @booking.scheduled_time.to_s
    fill_in "Service", with: @booking.service_id
    fill_in "Status", with: @booking.status
    fill_in "User", with: @booking.user_id
    click_on "Update Booking"

    assert_text "Booking was successfully updated"
    click_on "Back"
  end

  test "should destroy Booking" do
    visit booking_url(@booking)
    click_on "Destroy this booking", match: :first

    assert_text "Booking was successfully destroyed"
  end
end
