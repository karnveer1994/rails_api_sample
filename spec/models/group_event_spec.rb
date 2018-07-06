require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  context 'before validation callbacks' do
    let(:group_event1) do
      FactoryBot.create(:group_event, duration: nil, start_date: Date.today, end_date: (Date.today + 2.day))
    end
    let(:group_event2) { FactoryBot.create(:group_event, duration: 2, start_date: Date.today, end_date: nil) }

    it { expect(group_event1.duration).to eq(2) }
    it { expect(group_event2.end_date).to eq(Date.today + 2.day) }
  end

  context 'should not publish when all the required information is updated' do
    let(:group_event) { FactoryBot.create(:group_event, description: nil) }
    it { expect(group_event.update(published: true)).to be_falsey }
  end

  context 'should publish when all the required information is updated' do
    let(:group_event) { FactoryBot.create(:group_event) }
    it { expect(group_event.update(published: true)).to be_truthy }
  end

  context 'start_date cannot be in the past' do
    let(:valid_event) { FactoryBot.build(:group_event) }
    let(:invalid_event) do
      FactoryBot.build(:group_event, start_date: (Date.today - 2.day))
    end
    it { expect(valid_event.valid?).to be_truthy }
    it { expect(invalid_event.valid?).to be_falsey }
  end

  context 'end_date cannot be lesser than start_date' do
    let(:valid_event) { FactoryBot.build(:group_event) }
    let(:invalid_event) do
      FactoryBot.build(:group_event, start_date: (Date.today + 4.day), end_date: (Date.today + 2.day))
    end
    it { expect(valid_event.valid?).to be_truthy }
    it { expect(invalid_event.valid?).to be_falsey }
  end

  context 'don\'t apply validation if not published' do
    let(:group_event) { GroupEvent.new }
    it { expect(group_event).to_not validate_presence_of(:name) }
    it { expect(group_event).to_not validate_presence_of(:description) }
    it { expect(group_event).to_not validate_presence_of(:start_date) }
    it { expect(group_event).to_not validate_presence_of(:end_date) }
    it { expect(group_event).to_not validate_presence_of(:duration) }
    it { expect(group_event).to_not validate_presence_of(:location) }
  end

  context 'apply validation if published' do
    let(:group_event) { GroupEvent.new(published: true) }
    it { expect(group_event).to validate_presence_of(:name) }
    it { expect(group_event).to validate_presence_of(:description) }
    it { expect(group_event).to validate_presence_of(:start_date) }
    it { expect(group_event).to validate_presence_of(:end_date) }
    it { expect(group_event).to validate_presence_of(:duration) }
    it { expect(group_event).to validate_presence_of(:location) }
  end
end
