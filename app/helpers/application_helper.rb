# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

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

end
