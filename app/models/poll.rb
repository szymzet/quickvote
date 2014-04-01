class Poll < ActiveRecord::Base
  has_many :questions

  def self.find_by_hashed_id(hashed_id)
    find(self.hasher.decrypt(hashed_id).first)
  end

  def self.hasher
    Hashids.new('This is quickvote app! - salt', 8)
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
end
