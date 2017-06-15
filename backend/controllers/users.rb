class ArchivesSpaceService < Sinatra::Base

  Endpoint.get('/users')
    .description("Get a list of users")
    .params([ "show_hidden", BooleanParam, "Flag to show hidden users", :optional => true ])
    .paginated(true)
    .permissions([])
    .returns([200, "[(:resource)]"]) \
  do
    if  params[:show_hidden] 
      # we need to get all users except system_users ( admin user is a system
      # but not hidden user... ) 
      handle_listing(User, params, "is_hidden_user = 0 OR is_system_user = 0" )
    else
      handle_listing(User, params, { :is_hidden_user => 0 })
    end
  end

 Endpoint.get('/users/:id/activate')
    .description("Set a user to be activated")
    .params(["id", Integer, "The username id to fetch"])
    .permissions([:manage_users])
    .returns([200, "(:user)"]) \
  do
    user = User[params[:id]]

    if user && user.is_system_user == 0
			user.update( :is_hidden_user => 0 )	
			json = User.to_jsonmodel(user)
      json.permissions = user.permissions
      json_response(json)
    else
      raise NotFoundException.new("User wasn't found")
    end
	end

 Endpoint.get('/users/:id/deactivate')
    .description("Set a user to be deactivated")
    .params(["id", Integer, "The username id to fetch"])
    .permissions([:manage_users])
    .returns([200, "(:user)"]) \
  do
    user = User[params[:id]]

    if user && user.is_system_user == 0
			user.update( :is_hidden_user => 1 )	
			json = User.to_jsonmodel(user)
      json.permissions = user.permissions
      json_response(json)
    else
      raise NotFoundException.new("User wasn't found")
    end
	end


end
