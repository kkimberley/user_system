require 'rails_helper'

describe 'the profile process', type: :feature do
  let!(:user) { User.create(email: 'user@example.com', password: 'password') }

  feature 'user can edit username and password in the profile page' do
    scenario 'modify username and password sucessfully' do
      visit '/sessions/new'
      fill_in 'email', with: 'user@example.com'
      fill_in 'password', with: 'password'
      click_button 'Submit'

      expect(page).to have_selector("#user_username[value='user']")

      fill_in 'user_username', with: 'kimberley'
      fill_in 'user_password', with: 'new_password'
      click_button 'Submit'

      user.reload
      expect(page).to have_content 'update successfully.'
      expect(user.username).to eq 'kimberley'
      expect(page).to have_css('#user_email[disabled="disabled"]')
    end

    scenario 'modify fail: username too short' do
      visit '/sessions/new'
      fill_in 'email', with: 'user@example.com'
      fill_in 'password', with: 'password'
      click_button 'Submit'
      fill_in 'user_username', with: 'kk'
      fill_in 'user_password', with: 'new_password'
      click_button 'Submit'

      user.reload
      expect(page).to have_content 'update fail'
      expect(user.username).to eq 'user'
      expect(page).to have_css('#user_email[disabled="disabled"]')
    end
  end
end
