require "httparty"
require "json"
require "./lib/roadmap"

class Kele
  include HTTParty
  include Roadmap

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

  def get_mentor_availability(mentor_id)
    response = self.class.get(base_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentor_avail = JSON.parse(response.body)
  end

  def get_messages(page)
    response = self.class.get(base_url("message_threads"), body: {"page" => page}, headers: { "authorization" => @auth_token })
    @message = JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token, subject, stripped_text)
    response = self.class.post(base_url("messages"), body: {"sender" => sender, "recipient_id" => recipient_id, "token" => token, "subject" => subject, "stripped-text" => stripped_text}, headers: {"authorization" => @auth_token})
    puts "Your message has been sent!" if response.success?
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    response = self.class.post(base_url("checkpoint_submissions"), body: {"assignment_branch" = assignment_branch, "assignment_commit_link" = assignment_commit_link, "checkpoint_id" = checkpoint_id, "comment" = comment, "enrollment_id" = enrollment_id}, headers: {"authorization" = @auth_token})
    puts 'Your submission has been processed!' if response.success?
  end

  private

  def base_url(ext)
    "https://www.bloc.io/api/v1/#{ext}"
  end

end
