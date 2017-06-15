my_routes = [File.join(File.dirname(__FILE__), "routes.rb")]
ArchivesSpace::Application.config.paths['config/routes'].concat(my_routes)

Rails.application.config.after_initialize do
  UsersController.class_eval do
    set_access_control  "manage_users" => [:index, :edit, :update, :delete, :activate, :deactivate],
                             "manage_repository" => [:manage_access, :edit_groups, :update_groups, :complete],
                             :public => [:new, :create]
    
    def index
      show_hidden = params[:show_hidden] || false 
      @search_data = JSONModel(:user).all(:page => selected_page, :show_hidden => show_hidden)
    end

    def activate
      if JSONModel::HTTP::get_json("/users/#{params[:id]}/activate")
				flash[:success] = I18n.t("plugins.aspace_suppress_user.messages.activated") 
     	else 
				flash[:error] = I18n.t("plugins.aspace_suppress_user.messages.error") 
			end	
			redirect_to :action => :index
    end
    
    def deactivate
      if JSONModel::HTTP::get_json("/users/#{params[:id]}/deactivate")
				flash[:success] = I18n.t("plugins.aspace_suppress_user.messages.deactivated") 
     	else 
				flash[:error] = I18n.t("plugins.aspace_suppress_user.messages.error") 
			end	
			redirect_to :action => :index
    end

  end
end
