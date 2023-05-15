# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Residents', type: :request do
  describe 'POST /residents' do
    context 'with valid attributes' do
      let(:resident_params) { FactoryBot.attributes_for(:resident_with_address) }

      before do
        allow_any_instance_of(TwilioClient).to receive(:send_text)
      end

      it 'creates a new resident' do
        expect do
          post residents_url, params: { resident: resident_params }
        end.to change(Resident, :count).by(1)
      end

      it 'notify an email' do
        expect do
          post residents_url, params: { resident: resident_params }
        end.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'redirects to the created resident' do
        post residents_url, params: { resident: resident_params }
        expect(response).to redirect_to(Resident.last)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_params) { { resident: { full_name: '', email: 'invalid_email' } } }

      it 'does not create a new resident' do
        expect do
          post residents_url, params: invalid_params
        end.to_not change(Resident, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let(:resident) { create(:resident_with_address) }
    let(:valid_attributes) { { full_name: 'João', email: 'joao@example.com' } }
    let(:invalid_attributes) { { full_name: '', email: 'joao' } }

    context 'with valid parameters' do
      it 'updates the requested resident' do
        patch "/residents/#{resident.id}", params: { id: resident.id, resident: valid_attributes }
        resident.reload
        expect(resident.full_name).to eq('João')
        expect(resident.email).to eq('joao@example.com')
      end

      it 'redirects to the resident' do
        patch "/residents/#{resident.id}", params: { id: resident.id, resident: valid_attributes }
        expect(response).to redirect_to(resident_url(resident))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the resident' do
        expect {
          patch "/residents/#{resident.id}/update_status", params: { id: resident.id, resident: invalid_attributes }
        }.to_not change { resident.reload.full_name }
      end
    end
  end

  describe 'PATCH #update_status' do
    let(:resident) { create(:resident) }

    context 'with valid parameters' do
      it 'updates the resident status' do
        patch "/residents/#{resident.id}/update_status", params: { id: resident.id, resident: { status: 'inactive' } }
        resident.reload
        expect(resident.status).to eq('inactive')
      end

      it 'notify an email' do
        expect do
          patch "/residents/#{resident.id}/update_status", params: { id: resident.id, resident: { status: 'inactive' } }
        end.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'redirects to residents index' do
        patch "/residents/#{resident.id}/update_status", params: { id: resident.id, resident: { status: 'inactive' } }
        expect(response).to redirect_to(residents_path)
      end
    end    
  end
end
