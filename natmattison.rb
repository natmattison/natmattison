require 'sinatra'
require 'slim'
require 'httparty'
require 'json'
require 'yaml'

class Natmattison < Sinatra::Application

  get '/' do
    File.read(File.join('public', 'index.html'))
  end

  get '/resume' do
    File.read(File.join('public', 'resume.html'))
  end

  get '/pdfresume' do
    content_type :pdf
    File.read(File.join('public', 'natmatresume.pdf'))
  end

end

