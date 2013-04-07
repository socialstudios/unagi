Unagi::App.controllers :show do
  get :index, :with => :id do
    @show_id = params[:id]

    '''
    @next_show = nil
    found = nil
    Show.each do |show|
      if found then
        @next_show = show.id
        break
      end
      if @show_id == show.id then
        found = true
      end
    end
    '''

    show_obj = Show.find_by(id: params[:id])
    @title = show_obj.title
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
