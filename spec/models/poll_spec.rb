require 'spec_helper'

describe Poll do
  describe '#questions_from_string' do
    it 'Creates questions from comma separated string' do
      poll = Poll.new
      poll.questions_from_string('chair, sofa, bed')
      expect(poll.questions.size).to eq 3
      expect(poll.questions.map(&:name)).to eq %w{chair sofa bed}
    end

    it 'Removes empty questions' do
      poll = Poll.new
      poll.questions_from_string(",aa, bb ,\ncc\n,\t,\tdd")
      expect(poll.questions.size).to eq 4
      expect(poll.questions.map(&:name)).to eq %w{aa bb cc dd}
    end
  end
end
