require 'rails_helper'

RSpec.describe Api::GroupEventsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/group_events').to route_to(
        'api/group_events#index', format: 'json'
      )
    end

    it 'routes to #published' do
      expect(get: '/api/group_events/published').to route_to(
        'api/group_events#published', format: 'json'
      )
    end

    it 'routes to #unpublished' do
      expect(get: '/api/group_events/unpublished').to route_to(
        'api/group_events#unpublished', format: 'json'
      )
    end

    it 'routes to #deleted' do
      expect(get: '/api/group_events/deleted').to route_to(
        'api/group_events#deleted', format: 'json'
      )
    end

    it 'routes to #create' do
      expect(post: '/api/group_events').to route_to(
        'api/group_events#create', format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/group_events/1').to route_to(
        'api/group_events#update', id: '1', format: 'json'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/group_events/1').to route_to(
        'api/group_events#update', id: '1', format: 'json'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/api/group_events/1').to route_to(
        'api/group_events#destroy', id: '1', format: 'json'
      )
    end
  end
end
