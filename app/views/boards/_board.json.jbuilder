json.extract! board, :id, :name, :description, :topics_count, :posts_count, :locked, :created_at, :updated_at
json.url board_url(board, format: :json)
