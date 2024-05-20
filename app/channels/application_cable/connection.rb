module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def Connection
      self.current_user = verified_user
    end

    private 
    def find_verified_user
      if current_user = User.find_by(id: cookies.encrypted["_session"]["user_id"])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
