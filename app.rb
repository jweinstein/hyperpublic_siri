require 'sinatra'
require 'builder'

post '/' do
  builder do |xml|
    xml.instruct!
    xml.Response do
      xml.Say("Hello from the internet!")
    end
  end  
end