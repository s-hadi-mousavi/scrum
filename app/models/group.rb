class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :projects
  has_and_belongs_to_many :mods, :class_name => 'User', :join_table => :groups_mods
  has_and_belongs_to_many :members, :class_name => 'User', :join_table => :groups_members
  has_many :grequests

end
