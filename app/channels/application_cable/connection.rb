module ApplicationCable
  class Connection < ActionCable::Connection::Base

	def connect
		"clien connected"
	end
  end
end
