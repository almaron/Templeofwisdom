json.topics @topics do |topic|

end

json.total (@all_topics.count.to_f / 10).cXeil if @all_topics