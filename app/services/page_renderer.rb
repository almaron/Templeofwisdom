class PageRenderer < ::WillPaginate::ActionView::LinkRenderer
  protected

  def url(page)
    @base_url_params ||= begin
      url_params = merge_get_params(default_url_params)
      url_params[:only_path] = true
      merge_optional_params(url_params)
    end

    url_params = @base_url_params.dup
    add_current_page_param(url_params, page)
    url_params[:post] = nil
    @template.url_for(url_params)
  end

  def html_container(html)
    tag :div, tag(:ul, html), container_attributes
  end

  def page_number(page)
    tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
  end

  def gap
    tag :li, link(super, '#'), :class => 'disabled'
  end

  def previous_or_next_page(page, text, classname)
    tag :li, link(text, page || '#'), class: [classname[0..3], classname, ('disabled' unless page)].join(' ')
  end

end
