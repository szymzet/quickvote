class Question < ActiveRecord::Base
  belongs_to :poll

  def vote!
    self.votes += 1
  end
end
