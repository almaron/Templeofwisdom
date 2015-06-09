module DirectoryHelper
  def directory_path(dir_type, item)
    "/directory/#{dir_type}s/#{item.to_param}"
  end
end