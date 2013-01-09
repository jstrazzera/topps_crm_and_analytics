class AddCurrentBestGroupToMaBandit < ActiveRecord::Migration
  def change
    add_column :ma_bandits, :current_best_group, :string
  end
end
