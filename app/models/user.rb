class User < ApplicationRecord
  include OperationLogger

  validates :name, presence: true

  def as_json(options = nil)
    super({ only: [:id, :name, :balance] }.merge(options || {}))
  end
end
