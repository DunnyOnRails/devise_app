json.extract! conversation, :id, :title, :content, :locked, :subject_id, :user_id, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
