json.(@message, :head, :text)
json.char_id @message.char_id || current_user.default_char.id
json.char_ids params[:char_id] ? [params[:char_id].to_i] : @message.reply_ids || []
