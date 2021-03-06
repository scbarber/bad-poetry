ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  map.connect '', :controller => 'view'
  map.connect 'tag/:tag', { :controller => 'view', :action => 'bytag' }
  map.connect 'author/:id', { :controller => 'view', :action => 'byauthor' }
  map.connect 'today', { :controller => 'view', :action => 'bydate', :condition => 'date(created_at) = current_date()' }
  map.connect 'week', { :controller => 'view', :action => 'bydate', :condition => "date_format(created_at, '%X-%V') = date_format(now(), '%X-%V')" }
  map.connect 'month', { :controller => 'view', :action => 'bydate', :condition => "date_format(created_at, '%Y-%m') = date_format(now(), '%Y-%m')" }


  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
