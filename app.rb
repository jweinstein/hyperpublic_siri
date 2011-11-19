require 'rubygems'
require 'sinatra'
require 'twiliolib'

post '/sms' do
  @message = params[:sms]
  @phone = params[:phone]
  
  require 'twilio-ruby'

  # put your own credentials here
  account_sid = 'ACeb9fc2d72e8b4242a4849122cfea4fc3'
  auth_token = '4e4814223f23f49184a2f318365d0781'

  # set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new account_sid, auth_token

  d = {
    'From' => CALLER_ID,
    'To' => @phone,
    'Body' => @message
  }

  resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', d)
  resp.error! unless resp.kind_of? Net::HTTPSuccess
  puts "code: %s\nbody: %s" % [resp.code, resp.body]
  
  redirect('/')
end

account_sid = 'ACeb9fc2d72e8b4242a4849122cfea4fc3'
auth_token = '4e4814223f23f49184a2f318365d0781'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

@account = @client.account 

get '/' do
  code = "<%= Time.now %>"
  erb code 
end

get '/voice' do
  response =<<EOF
<Response>
  <Say>Welcome to moocode. Please wait while we connect you.</Say>
  <Dial>+14109132877</Dial>
</Response>
EOF
end

get '/sms' do
  response =<<EOF
<Response>

</Response>
EOF
end
