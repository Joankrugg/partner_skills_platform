json.extract! subscription, :id, :user_id, :start_date, :end_date, :status, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
