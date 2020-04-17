class AddScoreDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :hole, :string
  	add_column :users, :par, :string
  	add_column :users, :round, :string
  	add_column :users, :status, :string
  end
end
