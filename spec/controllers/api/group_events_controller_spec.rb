require 'rails_helper'

RSpec.describe Api::GroupEventsController, type: :controller do
  let!(:group_event) { FactoryBot.create(:group_event) }

  describe 'GET index' do
    it 'get all group events' do
      get :index
      expect(result(response.body).count).to eq(1)
    end
  end

  describe 'POST create' do
    it 'create group event' do
      post :create, params: { group_event: group_event_params }
      expect(result(response.body)['name']).to eq('Event 1')
    end
  end

  describe 'PUT update' do
    it 'update group event' do
      put :update, params: { group_event: group_event_params, id: group_event.id }
      expect(result(response.body)['description']).to eq(
        'Test description for Event 1'
      )
    end
  end

  describe 'GET published' do
    it 'return all published events' do
      group_event.update(published: true)
      get :published
      expect(result(response.body).count).to eq(1)
    end
  end

  describe 'GET unpublished' do
    it 'return unpublished events' do
      get :unpublished
      expect(result(response.body).count).to eq(1)
    end
  end

  describe 'GET deleted' do
    it 'get all removed events' do
      group_event.update(deleted_at: Time.now)
      get :deleted
      expect(result(response.body).count).to eq(1)
    end
  end

  describe 'DELETE destroy' do
    it 'delete group event' do
      delete :destroy, params: { id: group_event.id }
      expect(response.body).to eq(
        'Group Event has been successfully deleted.'
      )
    end
  end

  private

  def group_event_params
    {
      name: 'Event 1',
      description: 'Test description for Event 1',
      location: 'India',
      start_date: Date.today,
      end_date: Date.today + 2.days
    }
  end

  def result(body)
    JSON.parse(body)
  end
end
