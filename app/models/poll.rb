class Poll < ActiveRecord::Base
  has_many :questions

  def questions_from_string(questions_string)
    names = questions_string.split(',').map(&:strip).reject(&:empty?)
    names.each_with_object(self.questions) do |name, questions|
      questions << Question.new(name: name)
    end
  end
end
