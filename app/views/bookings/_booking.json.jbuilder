json.extract! booking, :id, :user_id, :service_id, :scheduled_time, :status, :created_at, :updated_at
json.url booking_url(booking, format: :json)
