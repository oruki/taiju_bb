# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include CalendarHelper
  include DatePickerHelper
  
  
  def link_to_back (description = "Back")
    referer = request.env["HTTP_REFERER"]
    return false if !referer
    getIt = request.env["REQUEST_URI"].split("?")[1]
    if getIt.nil?
      getIt = ""
    else
      getIt = "?" + getIt if !getIt.match(/\?/)
    end
    link_to description, referer + getIt
  end
  
end

#---
# Excerpted from "Agile Web Development with Rails, 2nd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails2 for more book information.
#---
module BuilderHelper
  def tagged_form_for(name, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : {}
    options = options.merge(:builder => TaggedBuilder)
    args = (args << options)
    form_for(name, *args, &block)
  end
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