# encoding: UTF-8
require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController, type: :controller do
  let(:user) { FactoryBot.create :user }

  describe '#show' do
    before { user }

    context 'as anonymous' do
      it 'should not be accessible' do
        get :show, params: {id: user.id}

        expect(response.status).to eq(401)
      end
    end

    context 'as user' do
      it 'should be allow access to my profile' do
        set_current_user user
        get :show, params: {id: user.id}

        expect(response.status).to eq(200)
      end
    end

    context 'as admin' do
      it 'should not be accessible' do
        set_current_user FactoryBot.create(:admin)
        get :show, params: {id: user.id}

        expect(response.status).to eq(200)
      end
    end
  end

  describe '#update' do
    before { user }

    context 'as anonymous' do
      it 'should not be accessible' do
        put :update, params: {id: user.id, user: {user_name: 'Bobby'}}

        expect(response.status).to eq(401)
      end
    end

    context 'as user' do
      it 'should be allow to update to my profile' do
        set_current_user user
        put :update, params: {id: user.id, user: {user_name: 'Bobby'}}

        expect(response.status).to eq(302)
      end
    end

    context 'as admin' do
      it 'should not be accessible' do
        set_current_user FactoryBot.create(:admin)
        put :update, params: {id: user.id, user: {user_name: 'Bobby'}}

        expect(response.status).to eq(302)
      end
    end
  end
end
