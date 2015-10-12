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
      p session
      !session[:id].nil?
    end

    def protected!(erb_key)
      if authorized?
        erb erb_key
      else
        redirect to('/login')
      end
    end
  end

  get '/' do
    erb :index
  end

  get '/app' do
    protected!(:app)
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
      redirect to('/app')
    end
  end

  get '/logout' do
    session.clear
    p session
    redirect to('/login')
  end

  get '/init' do
    User.first_or_create(email: 'rahij.ramsharan@gmail.com', password: 'test')
  end

  post '/upload' do
    xml_doc  = Nokogiri::XML(params[:svgSource])
    print xml_doc
    svg_path = xml_doc.xpath('//svg:path', 'svg' => 'http://www.w3.org/2000/svg')
    d_value = svg_path.attr('d').value
    d_value.sub!("m", "m ")
    d_value.gsub!(/(.*)(z)(.*)/, '\1 z\3')
    svg_path.attr('d', d_value)
    print xml_doc.to_xml
  end
end
