# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  module PrototypeHelper
    CALLBACKS    = Set.new([ :uninitialized, :loading, :loaded,
                           :interactive, :complete, :failure, :success ] +
                           (100..599).to_a)
    AJAX_OPTIONS = Set.new([ :before, :after, :condition, :url,
                           :asynchronous, :method, :insertion, :position,
                           :form, :with, :update, :script ]).merge(CALLBACKS)
  end

  def show_page_title
    #!@user.nil? && !@user.company.blank? ? @user.company : 'gullery photo gallery'
    if @project
      'Nayabei - Artist - ' + @project.name
    else
      'Nayabei - Artist'
    end
  end

  def show_page_nav
    user = User.find(:first)
    return 'gullery photo gallery' if user.nil?
    #nav = link_to(user.company, :controller => '/')
    nav = user.company
    if @project
      case @project.id
        when 2
          #nav += ' ' + link_to((@project.name), photography_url) if @project
          nav += ' ' + content_tag(:small, link_to((@project.name), photography_url)) if @project
        when 1
          nav += ' ' + content_tag(:small, link_to((@project.name), paintings_url)) if @project
        #nav += ' ' + link_to((@project.name), paintings_url) if @project
        else
          nav += ' ' + content_tag(:small, link_to((@project.name), projects_url(:action => 'show', :id => @project))) if @project
      end
    else
      nav += ' ' + content_tag(:small, link_to((@project.name), projects_url(:action => 'show', :id => @project))) if @project
    end
    nav
  end

  def show_analytics
    <<-EOT
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-10863270-1");
pageTracker._trackPageview();
} catch(err) {}</script>

    EOT
  end

  def selected(path)
    request.path_parameters.values.any?{|pp| pp == path} ? 'selected' : ''
  end

  def mailto(email)
    link_to email, "mailto:#{email}"
  end

  # Hack for Markaby and Rails 2.0
  def string_path(string)
    string
  end



  # Makes the element with the DOM ID specified by +element_id+ sortable
  # by drag-and-drop and make an Ajax call whenever the sort order has
  # changed. By default, the action called gets the serialized sortable
  # element as parameters.
  #
  # Example:
  #   <%= sortable_element("my_list", :url => { :action => "order" }) %>
  #
  # In the example, the action gets a "my_list" array parameter
  # containing the values of the ids of elements the sortable consists
  # of, in the current order.
  #
  # You can change the behaviour with various options, see
  # http://script.aculo.us for more documentation.
  def sortable_element(element_id, options = {})
    javascript_tag(sortable_element_js(element_id, options).chop!)
  end

  def sortable_element_js(element_id, options = {}) #:nodoc:

    options[:with]     ||= "Sortable.serialize('#{element_id}')"
    options[:onUpdate] ||= "function(){" + remote_function(options) + "}"
    options.delete_if { |key, value| PrototypeHelper::AJAX_OPTIONS.include?(key) }

    [:tag, :overlap, :constraint, :handle].each do |option|
      options[option] = "'#{options[option]}'" if options[option]
    end

    options[:containment] = array_or_string_for_javascript(options[:containment]) if options[:containment]
    options[:only] = array_or_string_for_javascript(options[:only]) if options[:only]

    %(Sortable.create('#{element_id}', #{options_for_javascript(options)});)
  end


  # Returns the JavaScript needed for a remote function.
  # Takes the same arguments as link_to_remote.
  #
  # Example:
  #   <select id="options" onchange="<%= remote_function(:update => "options",
  #       :url => { :action => :update_options }) %>">
  #     <option value="0">Hello</option>
  #     <option value="1">World</option>
  #   </select>
  def remote_function(options)
    javascript_options = options_for_ajax(options)

    update = ''
    if options[:update] and options[:update].is_a?Hash
      update  = []
      update << "success:'#{options[:update][:success]}'" if options[:update][:success]
      update << "failure:'#{options[:update][:failure]}'" if options[:update][:failure]
      update  = '{' + update.join(',') + '}'
    elsif options[:update]
      update << "'#{options[:update]}'"
    end

    function = update.empty? ?
      "new Ajax.Request(" :
      "new Ajax.Updater(#{update}, "

    function << "'#{url_for(options[:url])}'"
    function << ", #{javascript_options})"

    function = "#{options[:before]}; #{function}" if options[:before]
    function = "#{function}; #{options[:after]}"  if options[:after]
    function = "if (#{options[:condition]}) { #{function}; }" if options[:condition]
    function = "if (confirm('#{escape_javascript(options[:confirm])}')) { #{function}; }" if options[:confirm]

    return function
  end

  protected
  def options_for_ajax(options)
    js_options = build_callbacks(options)

    js_options['asynchronous'] = options[:type] != :synchronous
    js_options['method']       = method_option_to_s(options[:method]) if options[:method]
    js_options['insertion']    = "Insertion.#{options[:position].to_s.camelize}" if options[:position]
    js_options['evalScripts']  = options[:script].nil? || options[:script]

    if options[:form]
      js_options['parameters'] = 'Form.serialize(this)'
    elsif options[:submit]
      js_options['parameters'] = "Form.serialize('#{options[:submit]}')"
    elsif options[:with]
      js_options['parameters'] = options[:with]
    end

    options_for_javascript(js_options)
  end

  def build_callbacks(options)
    callbacks = {}
    options.each do |callback, code|
      if PrototypeHelper::CALLBACKS.include?(callback)
        name = 'on' + callback.to_s.capitalize
        callbacks[name] = "function(request){#{code}}"
      end
    end
    callbacks
  end

  def method_option_to_s(method)
    (method.is_a?(String) and !method.index("'").nil?) ? method : "'#{method}'"
  end

end
