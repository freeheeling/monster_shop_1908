require 'rails_helper'

RSpec.describe 'As an admin user' do
  describe 'when I navigate to /merchants' do
    before :each do
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80_210, enabled?: false)
      @site_admin = User.create(name: 'Site Admin', address: '123 First', city: 'Denver', state: 'CO', zip: 80_233, email: 'site_admin@user.com', password: 'secure', role: 3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@site_admin)

      visit merchants_path
    end

    it 'it shows all merchants with their name, city, and state' do
      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_link(@bike_shop.name)
        expect(page).to have_content("#{@bike_shop.city}, #{@bike_shop.state}")
      end

      within "#merchant-#{@dog_shop.id}" do
        expect(page).to have_link(@dog_shop.name)
        expect(page).to have_content("#{@dog_shop.city}, #{@dog_shop.state}")
      end
    end

    it 'displays disable/enable links for merchants that are enabled/disabled' do
      within "#merchant-#{@bike_shop.id}" do
        click_link 'Disable'
      end
      
      @bike_shop.reload
      expect(current_path).to eq(merchants_path)
      expect(@bike_shop.enabled?).to eq(false)
      
      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_link('Enable')
      end
      
      within "#merchant-#{@dog_shop.id}" do
        click_link 'Enable'
      end
      
      @dog_shop.reload
      expect(current_path).to eq(merchants_path)
      expect(@dog_shop.enabled?).to eq(true)

      within "#merchant-#{@dog_shop.id}" do
        expect(page).to have_link('Disable')
      end
    end
      
    it 'displays a flash message when a merchant account is disabled' do
      within "#merchant-#{@bike_shop.id}" do
        click_link 'Disable'
      end

      expect(page).to have_content("#{@bike_shop.name} has been disabled!")
    end

    it 'displays a flash message when a merchant account is enabled' do
      within "#merchant-#{@dog_shop.id}" do
        click_link 'Enable'
      end

      expect(page).to have_content("#{@dog_shop.name} has been enabled!")
    end
  end
end
      
