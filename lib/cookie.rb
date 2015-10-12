class App
  helpers do

    # optional param `id` checks if the authorized user is the same as the user
    # whose details are being fetched
    def authorized_user(id = nil)
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      if @auth.provided? && @auth.basic? && @auth.credentials
        user = check_token_and_get_user(
          id: @auth.credentials[0],
          auth_token: @auth.credentials[1]
        )
        id.nil? ? user : (user && user.id === id ? user : nil)
      else
        nil
      end
    end

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

    def respond_as_unauthorized
      # headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end
  end

  get '/' do
    erb :index
  end

  get '/app' do
    erb :app
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
