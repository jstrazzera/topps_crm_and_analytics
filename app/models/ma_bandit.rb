class MaBandit < ActiveRecord::Base
  attr_accessible :app, :end_date, :groups, :name, :results, :start_date, :current_best_group
  has_many :ma_bandit_records
  serialize :results, Array
  serialize :groups, Array

  def self.build(name, app, groups)
  	mab = MaBandit.new
  	mab.name = name
  	mab.app = app
  	mab.groups = groups
  	# mab.results = mab.groups.map do |group| 
  	# 	[group,{success_count: 1, attempt_count: 1, ratio: 1.0}]
  	# end
  	# groups.each {|group| mab.results.update({group=>{success_count: 1, attempt_count: 1, ratio: 1.0}})}
	# mab.current_best_group = mab.calc_current_best_group 
	mab.update_results_and_best_group!
	mab.save!
	mab
  end

  def calc_current_best_group
  	puts results
  	best = results.max do |result1, result2|
  		result1[1][:ratio] <=> result2[1][:ratio]
  	end
  	best[0]
  end

  def update_results_and_best_group!
  	self.results = groups.map do |group|
  		attempt_count = ma_bandit_records.where(group: group).count + 1
  		success_count = ma_bandit_records.where(group: group, success: true).count + 1
  		ratio = success_count.to_f / attempt_count.to_f
  		[group, {attempt_count: attempt_count, 
  			success_count: success_count, 
  			ratio: ratio}]

  	end

  	self.current_best_group = calc_current_best_group
  	save!
  	self

  end

  def mark_records_as_success_or_fail!
  	ma_bandit_records.where(created_at: (DateTime.now - 7.days)..DateTime.now).each(&:update_success_or_fail)
  end

  def self.which_to_perform?(name, app, fan_id)
  	mab = MaBandit.find_by_name_and_app(name, app)
  	mab.retrieve_or_assign_fan(fan_id)

  end


  def retrieve_or_assign_fan(fan_id)
  	record = ma_bandit_records.find_by_fan_id(fan_id)
  	unless record
  		r = rand(10)
  		if r <= 6
  			if r == 6 
  				mark_records_as_success_or_fail!
  				update_results_and_best_group!
  			end
  			group = current_best_group
  		else
  			group = groups.shuffle.first
  		end
  		record = MaBanditRecord.new(fan_id: fan_id, ma_bandit_id: id, group: group)
  		record.save
  		record.group
  	end
	record.group

  end
end
