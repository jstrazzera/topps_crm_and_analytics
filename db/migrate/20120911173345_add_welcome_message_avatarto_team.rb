class AddWelcomeMessageAvatartoTeam < ActiveRecord::Migration
  def up
  	change_table :teams do |t|
  		t.string :welcome_message_avatar
  	end
  end

  def down
  	remove_column :teams, :welcome_message_avatar
  end
end
