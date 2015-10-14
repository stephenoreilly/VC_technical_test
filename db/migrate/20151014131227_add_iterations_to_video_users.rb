class AddIterationsToVideoUsers < ActiveRecord::Migration
  def change
    add_column :video_users, :iterations, :integer, :default => 0
  end
end
