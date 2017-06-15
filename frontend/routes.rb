ArchivesSpace::Application.routes.draw do
  [AppConfig[:frontend_proxy_prefix], AppConfig[:frontend_prefix]].uniq.each do |prefix|
     scope prefix do
        match('/users/:id/activate' => 'users#activate', :via => [:get], :as => :user_activate)
        match('/users/:id/deactivate' => 'users#deactivate', :via => [:get], :as => :user_deactivate)
     end
  end
end
