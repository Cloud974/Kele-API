require "httparty"

class Kele
  include HTTParty

  def initialize(email, password)
    @base = 'https://www.bloc.io/api/v1'
    response = Kele.post("#{@base}/sessions", body: {email: email, password: password})
    if response && response["auth_token"]
      @auth_token = response['auth_token']
      puts "Login successful"
    else
      puts "No Auth-Token found"
    end
  end

end
