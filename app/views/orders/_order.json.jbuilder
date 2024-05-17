json.extract! order, :id, :customer_name, :total_price, :created_at, :updated_at
json.url order_url(order, format: :json)
