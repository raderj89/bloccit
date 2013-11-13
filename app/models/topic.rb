class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public
  has_many :posts, dependent: :destroy

  self.posts.per_page = 10
end
