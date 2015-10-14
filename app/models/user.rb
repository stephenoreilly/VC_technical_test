class User < ActiveRecord::Base
  acts_as_decorables

  belongs_to :company

  has_many :badge_users
  has_many :badges, through: :badge_users

  has_many :video_users
  has_many :videos, through: :video_users

  RUBY_CLASSES_NAME = 'Ruby classes'.to_sym

  # Current badges - Any new badges must have name added here
  HALFWAY = 'Half-Way'
  ALLWAY = 'All-Way'
  SPEEDRUN = 'SpeedRun'

  def to_s
    name
  end

  def watch_video video
    videos << video
  end

  def watched? video
    videos.include? video
  end

  def update_badges badges
    # Any new badges need to declare the name as a constant above and then add a method here and define below
    self.add_speed_run_if_required badges
    self.add_half_way_if_required badges
    self.add_all_way_if_required badges
  end

  def add_speed_run_if_required badges
    if (self.has_completed_speed_run? and self.badges.empty?)
      self.badges << badges.detect{|b| b.name == SPEEDRUN}
    end
  end
  
  def has_completed_speed_run?
    (self.videos.uniq.size == 1) and (self.videos.first.name.to_sym == RUBY_CLASSES_NAME)
  end
  
  def add_half_way_if_required badges
    if (self.videos.uniq.size >= 2 and (self.does_not_have_badge? HALFWAY))
      self.badges << badges.detect{|b| b.name == HALFWAY}
    end
  end
  
  def add_all_way_if_required badges
    if (self.videos.uniq.size >= Video.all.size and self.does_not_have_badge? ALLWAY)
      self.badges << badges.detect{|b| b.name == ALLWAY}
    end
  end
  
  def does_not_have_badge? badge_name
    !self.badges.collect{|b| b.name}.include? badge_name
  end
end
