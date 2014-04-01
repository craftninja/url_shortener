require 'sinatra/base'

class UrlShortApp < Sinatra::Application
  URLS = []

  get '/' do
    erb :index
  end

  post '/' do
    original_url = params[:url_to_shorten]
    url_id = URLS.length+1
    shortened_url = "#{request.host_with_port}/#{url_id}"
    URLS << {
      :original_url => original_url,
      :permalink => url_id,
      :shortened_url => shortened_url,
    }
    this_path = "/#{URLS.length.to_s}"
    redirect this_path
  end

  get '/:id' do
    short_url_index = params[:id].to_i-1
    erb :show, locals: {
      :original_url => URLS[short_url_index][:original_url],
      :shortened_url => URLS[short_url_index][:shortened_url]
    }
  end
end