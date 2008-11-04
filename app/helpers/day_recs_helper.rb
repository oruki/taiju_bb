module DayRecsHelper
end

module DatePickerHelper
  def date_picker_field(object, method, show_suffixes = false, show_wday = false)
    days = %w{&#26085; &#26376; &#28779; &#27700; &#26408; &#37329; &#22303;}
    obj = instance_eval("@#{object}")
    value = obj.send(method)
    date_format = show_suffixes ? '%Y&#24180;%m&#26376;%d&#26085;' : '%Y/%m/%d'
    display_value = (value.respond_to?(:strftime) ? value.strftime(date_format) : value.to_s)
    if display_value.blank?
      display_value = '[ &#26085;&#20184;&#12434;&#36984;&#25246; ]' if display_value.blank?
    else
      display_value += value.respond_to?(:wday) ? ('(' + days[value.wday] + ')') : '' if show_wday
    end
    out = hidden_field(object, method)
    out << content_tag('a', display_value, :href => '#',
        :id => "_#{object}_#{method}_link", :class => '_demo_link',
        :onclick => "DatePicker.toggleDatePicker('#{object}_#{method}',#{show_suffixes},#{show_wday}); return false;")
    out << tag('div', :class => 'date_picker', :style => 'display: none',
                      :id => "_#{object}_#{method}_calendar")
    if obj.respond_to?(:errors) and obj.errors.on(method) then
      ActionView::Base.field_error_proc.call(out, nil) # What should I pass ?
    else
      out
    end
  end
end