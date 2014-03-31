class Poll < ActiveRecord::Base
  has_many :questions

  def questions_from_string(questions_string)
    names = questions_string.split(',').map(&:strip).reject(&:empty?)
    names.reduce(self.questions) do |questions, name|
      questions << Question.new(name: name)
    end
  end
end
