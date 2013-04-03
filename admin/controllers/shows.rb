Unagi::Admin.controllers :shows do
  get :index do
    @title = "Shows"
    @shows = Show.all
    render 'shows/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'show')
    @show = Show.new
    render 'shows/new'
  end

  post :create do
    @show = Show.new(params[:show])
    if @show.save
      @title = pat(:create_title, :model => "show #{@show.id}")
      flash[:success] = pat(:create_success, :model => 'Show')
      params[:save_and_continue] ? redirect(url(:shows, :index)) : redirect(url(:shows, :edit, :id => @show.id))
    else
      @title = pat(:create_title, :model => 'show')
      flash.now[:error] = pat(:create_error, :model => 'show')
      render 'shows/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "show #{params[:id]}")
    @show = Show.find(params[:id])
    if @show
      render 'shows/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'show', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "show #{params[:id]}")
    @show = Show.find(params[:id])
    if @show
      if @show.update_attributes(params[:show])
        flash[:success] = pat(:update_success, :model => 'Show', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:shows, :index)) :
          redirect(url(:shows, :edit, :id => @show.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'show')
        render 'shows/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'show', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Shows"
    show = Show.find(params[:id])
    if show
      if show.destroy
        flash[:success] = pat(:delete_success, :model => 'Show', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'show')
      end
      redirect url(:shows, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'show', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Shows"
    unless params[:show_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'show')
      redirect(url(:shows, :index))
    end
    ids = params[:show_ids].split(',').map(&:strip)
    shows = Show.find(ids)
    
    if shows.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Shows', :ids => "#{ids.to_sentence}")
    end
    redirect url(:shows, :index)
  end
end
