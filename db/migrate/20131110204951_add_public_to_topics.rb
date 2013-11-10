class AddPublicToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :public, :boolean, default: true
  end
end
