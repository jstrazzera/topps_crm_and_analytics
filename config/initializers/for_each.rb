class ActiveRecord::Relation
  def for_each(step = 1000, &block)
    c = count 
    (c / step).times do |i|
      self.limit(1000).offset(i*1000).each do |model|
        yield model
      end
    end
  end
end

class ActiveRecord::Base
	def self.for_all(step = 1000, &block)
	    c = count 
	    (c / step).times do |i|
	      self.limit(1000).offset(i*1000).each do |model|
	        yield model
	      end
	    end

	end
end
