require 'nokogiri'
require 'open-uri'
class Member < ApplicationRecord
  attr_accessor :friend_ids
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :member
  serialize :website_headings
  validates :name, :website_url, presence: true
  after_save :generate_shotern
  
  def friends_list
    friend_ids = self.friends.pluck(:id) + self.inverse_friends.pluck(:id)
    Member.where(id: friend_ids)
  end

  def inverse_friends_list
    Member.where.not(id: friends_list.pluck(:id).push(self.id))
  end

  def all_member_expect_self
    Member.where.not(id: self.id)
  end
  
  def add_friend(friend_id)
    friendships = self.friendships.new(friend_id: friend_id)
    friendships.save
  end

  def remove_all_friends
    self.friends_list.each do |friend|
      self.remove_friend(friend.id)
    end
  end

  def remove_friend(friend_id)
    friendship = self.friendships.where(friend_id: friend_id).first
    if (friendship)
      friendship.destroy
    else
      inverse_friendship = self.inverse_friendships.where(member_id: friend_id).first
      inverse_friendship.destroy
    end
  end

  def is_friend(friend_id)
    self.friends_list.where(id: friend_id).present?
  end

  def update_friends_list(friend_ids)
    if (friend_ids.present?)
      disable_friends = self.friends_list.where.not(id: friend_ids)
      if disable_friends.present?
        disable_friends.each do |disable_friend|
          self.remove_friend(disable_friend.id)
        end
      end
      friend_ids.each do |friend_id|
        self.add_friend(friend_id) unless self.is_friend(friend_id)
      end
    else
      self.remove_all_friends
    end
  end

  def self.wrap_web_content(id)
    member = Member.find_by(id: id)
    doc = Nokogiri::HTML(open(member.website_url))
    header_tags = (1..3).map { |num| "h#{num}" }
    headers = []
    heading_content = doc.css(*header_tags).map do |node|
      headers << node.name
      {'node' => node.name, 'value' => node.text.strip}
    end
    search_content = heading_content.map{|x| x["value"]}.join rescue ""
    member.update_columns(website_headings: heading_content, description: search_content)
  end

  def generate_shotern
    if self.website_url.present?
      client = Bitly::API::Client.new(token: ENV["BITLY_TOKEN"])
      bitlink = client.shorten(long_url: self.website_url)
      self.update_columns(shortening: bitlink.link) 
    end
  end

end