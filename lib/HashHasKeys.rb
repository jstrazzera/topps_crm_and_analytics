#this is just a little monkey patch to enable the Hash#has_keys? method
#it takes in either a splat or an array of keys and returns true only if the hash has all the keys given
#example usage:
#h={1=>3,  2=>4, 3=>5}
#h.has_keys?(1,2,5) => false
#h.has_keys?([1,2,3]) => true


module HashHasKeys

	Hash.instance_eval do
		define_method(:has_keys?) do |*arg|
			arg.flatten.each do |x|
				unless self.has_key? x
					return false
				end
			end
			return true
 		end
	end





end