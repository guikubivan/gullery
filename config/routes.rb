ActionController::Routing::Routes.draw do |map|
  map.connect '', :controller => "projects"

  map.signup 'signup', :controller => "account", :action => 'signup'
  map.login 'login', :controller => "account", :action => 'login'
  map.logout 'logout', :controller => "account", :action => 'logout'

  #Feed for the whole site
  map.feed 'feed', :controller => 'projects', :action => 'feed'

  #Custom routes for friendly urls plus feed of each gallery
  map.paintings 'paintings', :controller => 'projects', :action => 'show', :id => '1'
  map.photography 'photography', :controller => 'projects', :action => 'show', :id => '2'
  map.paintings_rss 'paintings/rss', :controller => 'projects', :action => 'rss', :id => '1'
  map.photography_rss 'photography/rss', :controller => 'projects', :action => 'rss', :id => '2'

  
  map.projects 'projects/:action/:id', :controller => 'projects'
  map.assets 'assets/:action/:id', :controller => 'assets', :action => 'show'
  map.account 'account/:action', :controller => 'account'

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
end
