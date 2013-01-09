module MainControllerHelpers
	def bleacher_speech_bubble_text_array
	["SOMEONE GET THE HONEY GLAZE, THIS HAM JUST GOT SMOKED!",
	"DON'T EVEN BOTHER WITH THE BAT NEXT TIME, YOU'RE NOT HITTING US ANYWAY",
	"HEY UMP, IF YOU'RE JUST GONNA WATCH THEN BUY A TICKET!!!",
	"THEY KILLED A COW FOR YOUR GLOVE, AT LEAST TRY TO USE IT!",
	"YOUR GLOVES HAVE MORE HOLES THAN AN FLA PRESIDENTIAL BALLOT!",
	"HEY PITCHER, WHY NOT JUST TURN AROUND AND THROW IT IN THE GAP???",
	"HEY BLUE, I THOUGHT ONLY HORSES SLEPT STANDING UP??",
	"YOU HAVEN'T DRIVEN ANYBODY HOME SINCE JUNIOR PROM!!!",
	"YOU COULDN'T CATCH A RASH AT A POISON IVY CONVENTION!",
	"MENDOZA CALLED, HE WANTS HIS LINE BACK"]



	end



	def get_focus_avatar_hash(params)
		response = {}
		# if params[:user_score]
		if params[:team] && params[:user_score] && params[:fan_name] && params[:avatar]
			if params[:team].length == 3
				team = Team.team_hash2[params[:team].upcase]
			else
				team = params[:team]
			end
			if team
				team = team.gsub("-", " ").gsub("%20", " ").gsub("_", " ")
		        
		        team = "a\'s" if (team == "athletics" || team == "as")
		        team = "dbacks" if (team == "diamondbacks" || team == "dbacks")
		        team = "white sox" if team == "whitesox"
		        team = "red sox" if team == "redsox"  
		        team = "blue jays" if team == "bluejays"
			    
				team = team.titleize
				
				response[:message] = "Join \& I\'ll prove #{team} fans know baseball best.  Look for #{params[:fan_name]} 
				above you. I\'ve got #{params[:user_score]} pts already!"
			else
				response[:message] = "JOIN OR I\'LL CURSE YOUR TEAM LIKE I DID THE CUBS"

			end
		else
			response[:message] = "JOIN OR I\'LL CURSE YOUR TEAM LIKE I DID THE CUBS"
		end
		
		response[:message] = response[:message].upcase
		response.update({avatar: (params[:avatar] || "avatar-2-3"),
		user_name: (params[:focus_avatar_name] || "").upcase,
		user_score: params[:focus_avatar_score] || "",
		user_location: (params[:loc] || "").gsub("%20", " ").upcase,
		user_team_logo: "promo_page/focus_avatar/logos/" + (params[:focus_avatar_logo] || "bunt_logo") + ".png"
		})



	end

	def get_bleacher_fans(avatar)
		bleacher_fans = %w( 
			
			redgirl
			beards
			)
		
		if !@browser.ipad?
			bleacher_fans.push("phanatic")
		else
			bleacher_fans.push("cropped_phanatic")
		end

		bleacher_fans.push (avatar == "avatar-2-3" ? "bubblegum" : "goat")

		speech_bubble_array = (bleacher_speech_bubble_text_array.shuffle).map {|x| x.upcase}

		bleacher_fans.zip(speech_bubble_array)

	end

	def casey_fan_dump
		result = ""
		Fan.select("fan_name, bunt_id, auth_type, called_up").each do |entry|
			a=[]
			[:fan_name, :bunt_id, :auth_type, :called_up].each do |attribute|
				a << entry.send(attribute)
			end
			result += a.join(",") + "\r"
		end

	end

end