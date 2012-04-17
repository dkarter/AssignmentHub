module ApplicationHelper
  class ColorPickerFormBuilder < ActionView::Helpers::FormBuilder
    def color_picker(method, options={})
        toret = "<div class=\"colorpicker\">" 
        options[:avaiable].each_pair do |key,opt|
          toret += "<div id=\"coloritem_#{key}\" class=\"coloritem " + (opt == options[:selected] ? "cpselected" : "") + "\" style=\"background: #{opt}\">" 
          toret += "  <a href=\"#\" class=\"colorpicker_link\" tag=\"\" onClick=\"set_color_picker('coloritem_#{key}','#{opt}');return false;\"></a>" 
          toret += "</div>\n" 
        end
        toret += "<input type=\"hidden\" name=\"#{@object_name.to_s}[#{method.to_s}]\" value=\"#{options[:selected]}\" id=\"hidden_color_picker\"/>" 
        toret += "<div class=\"clear\"></div>"
        toret += "</div>" 
        return toret.html_safe
    end
  end
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function("remove", "remove_field(this)")
  end
  
  def link_to_add_fields(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
      end
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
