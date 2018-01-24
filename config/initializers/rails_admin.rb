RailsAdmin.config do |config|
  config.model 'Board' do
      exclude_fields :posts_count, :topics_count, :slug, :subject
    end

  config.authenticate_with do
    if  warden.user
      redirect_to main_app.pages_main_path unless warden.user.administrator == true 
    else
      redirect_to main_app.pages_main_path
    end
  end

  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end