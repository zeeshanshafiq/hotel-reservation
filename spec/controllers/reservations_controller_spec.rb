require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do

  describe 'index' do
    before do
      restaurant.reservations.find_or_create_by!(shift_id: shift.id, table_id: table.id, guest_id: guest.id, guest_count: 2, reservation_at: '03:00 pm'.to_time)
      get :index,params: {restaurant_id: restaurant.id}
    end

    let (:restaurant) {Restaurant.find_or_create_by(name: 'Restaurant1', email: 'restaurant1@example.com', phone: '0111234567')}
    let(:shift) {restaurant.shifts.find_or_create_by(name: 'Morning', start_at: 28800, end_at: 39600)}
    let(:table) {restaurant.tables.find_or_create_by(name: 'Table1', min_capacity: 1, max_capacity: 5)}
    let(:guest) {Guest.find_or_create_by(name: 'Guest1', email: 'guest1@example.com')}

    it 'returns http sucess' do
      expect(response).to have_http_status(:success)
    end

    it 'reponse must have required attributes' do
      hash_body = nil
      expect { hash_body = JSON.parse(response.body) }.not_to raise_exception
      expect(hash_body.first.keys).to match_array(['id', 'reservation_time','guest_name','table_name', 'guest_count'])
    end
  end

  describe 'create' do
    before do
      post :create, params: {restaurant_id: restaurant.id, reservation: {shift_id: shift.id, table_id: table.id, guest_id: guest.id, guest_count: 2, reservation_at: '03:00 pm'.to_time}}
    end
    let(:restaurant) {Restaurant.create!(name: 'Restaurant1', email: 'restaurant1@example.com', phone: '0111234567')}
    let(:shift) {restaurant.shifts.create!(name: 'Morning', start_at: 28800, end_at: 39600)}
    let(:table) {restaurant.tables.create!(name: 'Table1', min_capacity: 1, max_capacity: 5)}
    let(:guest) {Guest.create!(name: 'Guest1', email: 'guest1@example.com')}

    it 'returns http sucess' do
      expect(response).to have_http_status(:success)
    end

  end

end