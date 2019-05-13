module OperationLogger
  extend ActiveSupport::Concern

  included do
    has_many :operations

    after_commit -> { log_operation('create') }, on: :create
  end

  def log_operation(operation_name)
    operations.create! do |o|
      o.name = operation_name
      o.data = as_json(only: logged_attributes)
    end
  end

  def logged_attributes
    attribute_names.without('id', 'created_at', 'updated_at')
  end
end
