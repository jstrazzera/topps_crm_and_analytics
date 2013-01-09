module MainHelper
	#view helpers
	def avatar_image_tag(avatar_name, full=true)
		#full controls whether we're dealing wiht the ipad or browser version of the page...
		#maybe unnecessary? 
		image_path = "promo_page/bleacher_avatars/" + (full ? "main/" : "ipad/")
		
		#slightly ugly
		hover_file = File.exists?("app/assets/images/" + image_path + avatar_name + "_hover.png") ? "hover_fan" : ""
			
		image_tag (image_path + avatar_name + ".png"), class: hover_file, 
			data: {hoveravatar: asset_path(image_path + avatar_name + "_hover" + ".png"),
						avatar: asset_path(image_path + avatar_name + ".png")}
		
	end

	def team_name_id_pairs
		(Team.pluck(:name).map {|x| x.gsub("_", " ").titleize}).zip(Team.pluck(:id))
	end

end
