class ApplicationController < ActionController::Base
  protect_from_forgery

  include AuthenticatedSystem

  helper_method :textilight, :textilize

  private
  before_filter :instantiate_controller_and_action_names

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end


  def textilight(text='')
    r = RedCloth.new text
    r.hard_breaks = false
    r.to_html.gsub(/^<p>/, '').gsub(/<\/p>$/, '')
  end

  def textilize(text='')
    r = RedCloth.new text
    r.hard_breaks = false
    r.to_html.gsub(/^\s+/, '')
  end

end
