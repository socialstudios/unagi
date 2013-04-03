Unagi::App.controllers :show do
  get :index do
    haml 'show/index'.to_sym, :layout => 'layouts/show'
  end

  get ':id.json', :provides => [:json] do
    show = Show.find_by(id: params[:id])
    show['lineup'] = JSON.parse(show.data)
    show.data = nil
    show.to_json
  end

  get ':id', :provides => [:html] do
    "Hello #{Show.find_by(id: params[:id]).to_json}"
  end


  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end


end
