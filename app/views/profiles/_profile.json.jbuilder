json.extract! profile, :id, :username, :user_image, :company_name, :main_email, :main_phone, :office_phone, :one_line_address, :created_at, :updated_at
json.url profile_url(profile, format: :json)
