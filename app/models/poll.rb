class Poll < ActiveRecord::Base
  has_many :questions
  has_and_belongs_to_many :users
  validates :title, presence: true, length: { minimum: 2, maximum: 240 }

  def self.find_by_hashed_id(hashed_id)
    find(hasher.decrypt(hashed_id).first)
  end

  def self.hasher
    Hashids.new(ENV['HASHIDS_SALT'], 8)
  end

  def questions_from_string(questions_string)
    names = questions_string.split(',').map(&:strip).reject(&:empty?)
    names.each_with_object(self.questions) do |name, questions|
      questions << Question.new(name: name)
    end
  end

  def hashed_id
    raise 'Cannot hash nil id' if self.id.nil?
    self.class.hasher.encrypt(self.id)
  end

   def most_voted_question
     most_voted = questions.max_by { |q| q.votes }
     return most_voted if questions.one? { |q| q.votes == most_voted.votes }
     nil
   end
end
