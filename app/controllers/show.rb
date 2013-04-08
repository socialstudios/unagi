Unagi::App.controllers :show do
  get '/create' do
    haml 'show/create'.to_sym, :layout => 'layouts/minimal'
  end

  post '/create' do
    # prepare post parameters for the db
    videos = Array.new
    videos.push params[:show]['opening']
    videos.push params[:show]['thevideo']
    videos.push params[:show]['closing']
    # isolate youtube id from the url
    for i in 0..2
      videos[i] = videos[i].split('=')[1]
    end
    prepared_data = {}
    prepared_data['data'] = {}
    prepared_data['title'] = 'dontcare'
    prepared_data['data']['videos'] = videos
    prepared_data['data']['topic'] = params[:show]['topic']
    prepared_data['data']['name'] = params[:show]['name']
    prepared_data['data']['email'] = params[:show]['email']
    prepared_data['data'] = prepared_data['data'].to_json
    # save to db
    @show = Show.new(prepared_data)
    if @show.save then
      @first = 'Thanks,'
      @message = 'your data has been saved.'
      @type = 'alert-success'
      @return_url = '/show'
      @button_caption = 'Continue'
      haml 'common/message'.to_sym, :layout => 'layouts/minimal'
    else
      @first = 'Error,'
      @message = 'Something went wrong, click back and try again.'
      @type = 'alert-error'
      @return_url = '/show/create'
      @button_caption = 'Try again'
      haml 'common/message'.to_sym, :layout => 'layouts/minimal'
    end
  end

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
