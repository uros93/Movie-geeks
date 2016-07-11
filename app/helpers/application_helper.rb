module ApplicationHelper
    def belongs_to_user?(resource)
    resource.user == current_user
    end
    
    def display_avatar(user)  
        unless user.avatar.nil? 
          image_tag(user.avatar, size: "50x50", class: "img-thumbnail") 
        else
          image_tag("assets/images/fallbacks/avatar.png", size: "50x50", class: "img-thumbnail")
        end    
    end
end
