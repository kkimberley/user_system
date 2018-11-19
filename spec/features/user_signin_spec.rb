require 'rails_helper'

describe 'the signin process', type: :feature do
  let!(:user) { User.create(email: 'user@example.com', password: 'password') }

  feature 'user can log in the system' do
    scenario 'signin sucessfully.' do
      visit '/sessions/new'
      fill_in 'email', with: 'user@example.com'
      fill_in 'password', with: 'password'
      click_button 'Submit'

      expect(page).to have_content 'Welcome To profile Page'
    end
  end
end
