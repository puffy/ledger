class Operation < ApplicationRecord
  belongs_to :user

  def performed_at
    created_at
  end

  def as_json(options = nil)
    super({ only: [:name, :data], methods: [:performed_at] }.merge(options || {}))
  end
end
