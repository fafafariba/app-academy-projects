class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_id, presence: true
  validate :respondent_already_answered

  belongs_to(
    :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_id
  )

  belongs_to(
    :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
    question.responses.where.not(id: self.id)
    #hella refactoredRe
  end

  def respondent_already_answered
    unless sibling_responses.exists?(user_id: self.user_id)
      return false
    else
      self.errors[:question] << "already answered"
    end
  end

end
