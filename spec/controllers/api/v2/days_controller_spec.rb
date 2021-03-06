require 'spec_helper'

describe Api::V2::DaysController, type: :controller do
  render_views

  let(:json) { JSON.parse response.body }

  describe 'GET index' do
    let(:day) { FactoryBot.create :day }
    let(:canteen) { day.canteen }
    before { day }

    it 'should answer with a list' do
      get :index, format: :json, params: {canteen_id: canteen.id}
      expect(response.status).to eq(200)

      expect(json).to be_an(Array)
      expect(json.size).to eq(1)
    end

    it 'should answer with a list of day nodes' do
      get :index, format: :json, params: {canteen_id: canteen.id}
      expect(response.status).to eq(200)

      expect(json[0]).to eq({
        date: day.date.iso8601,
        closed: day.closed
      }.as_json)
    end

    context '&start' do
      let(:today) { FactoryBot.create :today, closed: true }
      let(:canteen) { today.canteen }
      let(:tomorrow) { FactoryBot.create :tomorrow, canteen: canteen }
      let(:yesterday) { FactoryBot.create :yesterday, canteen: canteen }

      before do
        today && tomorrow && yesterday
        FactoryBot.create :day, canteen: canteen, date: yesterday.date - 1
        FactoryBot.create :day, canteen: canteen, date: yesterday.date - 2
        FactoryBot.create :day, canteen: canteen, date: tomorrow.date + 1
      end

      it 'should default to today if not given' do
        get :index, format: :json, params: {canteen_id: canteen.id}

        expect(json).to have(3).items
        expect(json[0]['date']).to eq(today.date.iso8601)
        expect(json[1]['date']).to eq(tomorrow.date.iso8601)
        expect(json[2]['date']).to eq((tomorrow.date + 1).iso8601)
      end
    end
  end

  describe 'GET show' do
    let(:day) { FactoryBot.create :day }
    let(:canteen) { day.canteen }
    before { canteen }

    it 'should answer with day' do
      get :show, format: :json,
        params: {canteen_id: canteen.id, id: day.to_param}

      expect(response.status).to eq(200)

      expect(json).to eq({
        date: day.date.iso8601,
        closed: day.closed
      }.as_json)
    end
  end
end
