require "httparty"
require "json"

class Kele
  include HTTParty

  def initialize(email, password)
    response = Kele.post(base_url("sessions"), body: {email: email, password: password})
    if response && response["auth_token"]
      @auth_token = response['auth_token']
      puts "Login successful"
    else
      puts "No Auth-Token found"
    end
  end

  def get_me
    response = self.class.get(base_url("users/me"), headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_roadmap
  end

  def get_checkpoint
  end

  private

  def base_url(ext)
    "https://www.bloc.io/api/v1/#{ext}"
  end

end
