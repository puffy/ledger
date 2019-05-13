require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'operation logging' do
    let(:user) { User.create!(name: 'Test') }

    it 'creates Operation after create' do
      expect { user }.to change(Operation, :count).by(1)
      expect(Operation.last.name).to eq 'create'
    end

    it 'creates Operation after update' do
      user
      expect {
        user.update(name: 'Test2')
      }.to change(Operation, :count).by(1)
      expect(Operation.count).to eq 2
      expect(Operation.last.name).to eq 'update'
    end
  end
end
