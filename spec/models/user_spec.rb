require 'spec_helper'

describe User do

  describe ".top_rated" do
    before(:each) do
      post = nil
      topic = create(:topic)
      @u0 = create(:user) do |user|
        post = user.posts.build(attributes_for(:post))
        post.topic = topic
        post.save
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
      end

      @u1 = create(:user) do |user|
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
        post = user.posts.build(attributes_for(:post))
        post.topic = topic
        post.save
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
        post = user.posts.build(attributes_for(:post))
        post.topic = topic
        post.save
        post = user.posts.build(attributes_for(:post))
        post.topic = topic
        post.save
      end

      @u2 = create(:user) do |user|
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
        post = user.posts.build(attributes_for(:post))
        post.topic = topic
        post.save
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
      end
    end

    it "should return users based on comments + posts" do
      User.top_rated.should eq([@u1, @u2, @u0])
    end
    it "should have `posts_count` on user" do
      users = User.top_rated
      users.first.posts_count.should eq("3")
    end
    it "should have `comments_count` on user" do
      users = User.top_rated
      users.first.comments_count.should eq("2")
    end
    it "should return @u0 for the bottom-ranked user" do
      users = User.top_rated
      users.last.should eq(@u0)
    end
  end

  describe "role?" do
    before(:each) do
      @u0 = create(:user)
      @u1 = create(:user) do |user|
        user.update_attribute(:role, "admin")
        user.save
      end
      @u2 = create(:user) do |user|
        user.update_attribute(:role, "moderator")
        user.save
      end
    end

    it "should not have a role of admin" do
      @u0.role.should_not eq("admin")
    end
    it "shout not have a role of member" do
      @u1.role.should_not eq("member")
    end
    it { @u1.role.should eq("admin") }
    it { @u2.role.should eq("moderator") }
  end
end