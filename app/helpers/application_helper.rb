module ApplicationHelper
  def custom_select(label, id, name, options)
    options_collection = []
    options.each {|entry| options_collection << "<option>#{entry}</option>" }
    html_insert = options_collection.join("")
      "
      <select id=#{id} name=#{name} style=\"display: none;\">".html_safe +
      html_insert.html_safe +
      "</select><div class=\"custom dropdown\"><a href=\"#\" class=\"current\">#{label}</a><a href=\"#\" class=\"selector\"></a><ul><li class=\"disabled\">This is a dropdown</li><li class=\"selected\">This is another option</li><li>This is another option too</li><li>Look, a third option</li></ul></div>
      ".html_safe
  end

  def current_process_step
    case request.env['PATH_INFO']
      when ""
        return 1
      when "/"
        return 1
      when jobs_path
        return 1
      when new_press_job_path
        return 2
      when press_jobs_path
        return 3
      when cost_analyses_path
        return 4
      when dashboards_path
        return 5
      when '/roi'
        return 6
    end
  end

  def enforce_float_zeros value, precision
    "%.#{precision}f" % value
  end
end
