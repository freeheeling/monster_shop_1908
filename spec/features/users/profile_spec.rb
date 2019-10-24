require 'rails_helper'

# As a registered user
# When I visit my profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data

# As a registered user
# When I visit my Profile page
# And I have orders placed in the system
# Then I see a link on my profile page called "My Orders"
# When I click this link my URI path is "/profile/orders"

RSpec.describe 'As a registered user' do
  describe 'when I visit my profile page' do
    it 'can see all profile data on the page except the password' do
      user = User.create(
        name: 'Bob', 
        address: '123 Main', 
        city: 'Denver', 
        state: 'CO', 
        zip: 80_233, 
        email: 'bob@email.com',
        password: 'secure'
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_path

      expect(current_path).to eq(profile_path)

      within '#user-info' do
        expect(page).to have_content('Name: Bob')
        expect(page).to have_content("Address: 123 Main")
        expect(page).to have_content("City: Denver")
        expect(page).to have_content("State: CO")
        expect(page).to have_content("Zip: 80233")
        expect(page).to have_content("Email: bob@email.com")
        expect(page).to have_link('Edit Profile')
      end
    end
  end
end