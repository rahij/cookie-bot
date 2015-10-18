class App
  helpers do
    def check_password_and_get_user(params)
      user = User.where(
        email: params[:email],
      ).last
      if user && user.password == params[:password]
        user
      else
        nil
      end
    end

    def authorized?
      !session[:id].nil?
    end
  end

  get '/' do
    erb :index, layout: false
  end

  get '/app' do
    unless authorized?
      redirect to('/login')
    end
    if params[:id]
      template = Template.find(params[:id])
    else
      template = nil
    end
    erb :app, locals: { template: template }
  end

  get '/editor' do
    erb :editor, layout: false
  end

  get '/init' do
    User.first_or_create(email: 'rahij.ramsharan@gmail.com', password: 'test')
  end

  get '/profile' do
    if authorized?
      erb :profile, locals: { user: User.includes(:templates).find(session[:id]) }
    else
      redirect to('/login')
    end
  end

  get '/gallery' do
    erb :gallery, locals: { templates: Template.where(is_public: true) }
  end

  post '/upload' do
    p session
    unless authorized?
      halt 401
    end
    template = Template.new(params)
    print template.svg_source + "\n"
    template.normalize_svg!
    template.stl_key = '/input_extruded.stl'
    user = User.find(session[:id])
    user.templates << template
    user.save!
    template.to_json
  end

  get '/size/:id' do
    unless authorized?
      redirect to('/login')
    end
    template = Template.find(params[:id])
    erb :size, locals: { template: template }
  end

  post '/size/:id' do
    unless authorized?
      redirect to('/login')
    end
    template = Template.find(params[:id])
    template[:size] = params[:size]
    template.save!
    redirect to("/material/#{params[:id]}")
  end

  get '/material/:id' do
    unless authorized?
      redirect to('/login')
    end
    template = Template.find(params[:id])
    erb :material, locals: { template: template }
  end

  post '/material/:id' do
    unless authorized?
      redirect to('/login')
    end
    template = Template.find(params[:id])
    template[:material] = params[:material]
    template[:is_public] = true if params[:is_public]
    template.save!
    redirect to('/profile')
  end

  get '/signup' do
    if authorized?
      redirect to('/app')
    end
    erb :signup
  end

  post '/signup' do
    user = User.create(params)
    if user.errors.messages.empty?
      session[:id] = user.id
      session[:email] = user.email
      redirect to('/app')
    else
      flash[:errors] = user.errors.messages
      redirect to('/signup')
    end
  end

  get '/login' do
    if authorized?
      redirect to('/app')
    else
      erb :login
    end
  end

  post '/login' do
    user = check_password_and_get_user(params)
    if user.nil?
      redirect to('/login?error=1')
    else
      session[:id] = user.id
      session[:email] = user.email
      redirect to('/app')
    end
  end

  get '/logout' do
    session.clear
    p session
    redirect to('/login')
  end
end
