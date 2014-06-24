partial = params[:short] ? 'short_char' : 'char'
json.partial! partial, collection: @chars, as: :char