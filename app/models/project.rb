class Project < ActiveRecord::Base
  attr_accessible :description, :name, :group_id, :user_id
  has_and_belongs_to_many :mods, :class_name => 'User', :join_table => :mods_projects
  has_and_belongs_to_many :members, :class_name => 'User', :join_table => :members_projects
  has_many :tasks
  has_and_belongs_to_many :languages
  belongs_to :group
  has_many :prequests

  validate :user_has_group;
  validates :description, presence: true;
  validates :name, presence:true;

  def user_has_group
    if mods.first.groups.find(group_id).nil?
      errors.add(:group_id, "must belong to you")
    end
  end
end
