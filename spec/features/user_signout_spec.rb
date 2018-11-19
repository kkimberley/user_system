require 'rails_helper'

describe 'the signout process', type: :feature do
  let!(:user) { User.create(email: 'user@example.com', password: 'password') }

  feature 'user can log out the system' do
    scenario 'signout sucessfully.' do
      visit '/sessions/new'
      fill_in 'email', with: 'user@example.com'
      fill_in 'password', with: 'password'
      click_button 'Submit'

      expect(page).to have_content 'Welcome To profile Page'

      click_link 'Logout'

      expect(page).to have_content 'Welcome To Login Page'
    end
  end
end
