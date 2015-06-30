require 'sinatra'
require 'slim'
require 'httparty'
require 'json'
require 'yaml'

class Natmattison < Sinatra::Application

  get '/' do
    # @image_url, @image_link = get_image_url('natmattison')
    # slim :index
    File.read(File.join('public', 'index.html'))
  end

  def get_image_url(username)
    
    consumer_key = ENV['FPX_CONSUMER_KEY']
    image_size = 3
    
    url = 'https://api.500px.com/v1/photos'
    
    begin
      # response = HTTParty.get(url, :query => {:consumer_key => consumer_key, :feature => 'user', :username => username, :rpp => '10', :image_size => image_size})
      response = HTTParty.get(url, :query => {consumer_key: consumer_key, feature: 'user', username: username, rpp:'10', image_size: image_size})
      image = response['photos'].sample
      image_url = image['image_url']
      image_link = "http://500px.com/photo/#{image['id']}"
    rescue Exception => e
      image_url = ''
      image_link = '#'
    end

    return image_url, image_link
  end

  def get_articles()
    consumer_key = ENV['POCKET_CONSUMER_KEY']
    access_token = ENV['POCKET_ACCESS_TOKEN']

    uri = "https://getpocket.com/v3/get/"

    begin
      response = HTTParty.post(uri, :headers => {"Content-Type" => "application/json"}, :body => {consumer_key: consumer_key, access_token: access_token, favorite: "1", count: "3"}.to_json)
    rescue Exception => e
      puts e
    end
    
    results = JSON.parse(response.body)

    articles = results['list'].values
  end

end

