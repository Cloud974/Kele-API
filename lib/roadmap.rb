require 'httparty'
require 'json'

module Roadmap
  include HTTParty
  include JSON

  def get_roadmap(roadmap_id)
    response = self.class.get(base_url("roadmaps/#{roadmap_id}"), headers: {"authorization" => @auth_token})
    @roadmap_id = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get(base_url("checkpoints/#{checkpoint_id}"), headers: {"authorization" => @auth_token})
    @checkpoint_id = JSON.parse(response.body)
  end


end
