json.(@message, :char_id, :head, :text)
json.char_ids params[:char_id] ? [params[:char_id].to_i] : []
