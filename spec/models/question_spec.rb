require 'spec_helper'

describe Question do
  it 'can be voted for' do
    question = Question.new(name: 'Something', votes: 4)
    question.vote!
    expect(question.votes).to eq 5
  end
end
