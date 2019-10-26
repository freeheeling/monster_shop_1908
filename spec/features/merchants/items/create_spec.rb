require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'merchant admin' do
    describe 'when I click add item from the merchant items index page' do
      it 'can create a new item from the new item form' do
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
        merchant_admin = meg.users.create!(
          name: 'Bob',
          address: '123 Main',
          city: 'Denver',
          state: 'CO',
          zip: 80_233,
          email: 'bob@email.com',
          password: 'secure',
          role: 2
        )
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_admin)

        name = 'Chamois Buttr'
        price = 18
        description = "No more chaffin'!"
        image_url = 'https://images-na.ssl-images-amazon.com/images/I/51HMpDXItgL._SX569_.jpg'
        inventory = 25

        visit merchant_items_new_path

        click_on 'Add New Item'

        expect(page).to have_link(@brian.name)
        expect(current_path).to eq("/merchants/#{@brian.id}/items/new")
        fill_in :name, with: name
        fill_in :price, with: price
        fill_in :description, with: description
        fill_in :image, with: image_url
        fill_in :inventory, with: inventory

        click_button 'Create Item'

        within "#item-#{Item.last.id}" do
          expect(page).to have_content(name)
          expect(page).to have_content("Price: $#{new_item.price}")
          expect(page).to have_css("img[src*='#{new_item.image}']")
          expect(page).to have_content('Active')
          expect(page).to_not have_content(new_item.description)
          expect(page).to have_content("Inventory: #{new_item.inventory}")
        end
      end
    end
  end
end
