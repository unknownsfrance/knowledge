module UsersHelper
  
  def self.all_as_array
    u = Hash.new
    User.all.each do |user| 
      u[user.id] = user.firstname
    end
    u
  end
  
end
