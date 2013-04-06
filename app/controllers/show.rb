Unagi::App.controllers :show do
  get :index, :with => :id do
    @show_id = params[:id];
    show = Show.find_by(id: params[:id])
    @title = show.title
    haml 'show/show'.to_sym, :layout => 'layouts/show'
  end

  get 'data/:id.json', :provides => [:json] do
     show = Show.find_by(id: params[:id])
     show = JSON.parse(show.data)
     show.to_json
  end

  get :index do
    @title = 'Shows'
    haml 'show/index'.to_sym, :layout => 'layouts/show'
  end
end
