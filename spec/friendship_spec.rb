require 'rails_helper'

RSpec.describe 'Friendship', type: :model do
  it 'this will create a new friendship' do
    user1 = User.create!(email: 'test1@email.com', name: 'test1', gravatar_url: 'http://www.gravatar.com/avatar/%22',
                         password: '123123')
    user2 = User.create!(email: 'test2@email.com', name: 'test2', gravatar_url: 'http://www.gravatar.com/avatar/%22',
                         password: '123123')
    f = Friendship.create!(creator_id: user1.id, receiver_id: user2.id, status: false)
    expect(Friendship.find(f.id).id).to eql(Friendship.last.id)
  end
end
