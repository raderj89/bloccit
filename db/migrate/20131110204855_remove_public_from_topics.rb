class RemovePublicFromTopics < ActiveRecord::Migration
  def up
    remove_column :topics, :public
  end

  def down
    add_column :topics, :public, :boolean
  end
end
