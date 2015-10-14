class VideoUser < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  def increase_iterations
    if self.iterations == 0
      self.iterations = 1
    else
      self.iterations += 1
    end
    self.save
  end
end
