require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe SessionsController, type: :controller do
  
  before do
    User.destroy_all
  end

  let(:connie) {User.create(name: 'Connie', password: 'M4heswaran')}
  
  describe 'post create' do
    it 'logs you in with the correct password' do
      post :create, user: {name: connie.name, password: connie.password}
      puts "CONNIE ID IS #{connie.id}, #{session[:user_id]}"
      expect(session[:user_id]).to eq(connie.id)
    end

    it 'rejects invalid passwords' do
      post :create, user: {name: connie.name, password: connie.password + 'x'}
      expect(session[:user_id]).to be_nil
    end

    it 'rejects empty passwords' do
      post :create, user: {name: connie.name, password: ''}
      expect(session[:user_id]).to be_nil
    end
  end
end
