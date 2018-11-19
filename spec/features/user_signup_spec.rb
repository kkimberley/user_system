require 'rails_helper'

describe 'the signup process', type: :feature do
  feature 'user can visit sign up page and sign up with email and password' do
    scenario 'signup sucessfully.' do
      visit '/users/new'
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Submit'

      expect(page).to have_content 'Welcome To profile Page'

      open_email('user@example.com')

      expect(current_email.to).to eq ['user@example.com']
      expect(current_email.subject).to eq 'Signup successfully.'
      expect(current_email).to have_content 'user@example.com'
    end

    scenario 'signup fail: invalid email format' do
      visit '/users/new'
      fill_in 'user_email', with: 'user'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Submit'

      expect(page).to have_content 'signup fail'
    end

    scenario 'signup fail: already exist email' do
      User.create(email: 'user@example.com', password: 'password')

      visit '/users/new'
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Submit'

      expect(page).to have_content 'signup fail'
    end

    scenario 'signup fail: password too short' do
      visit '/users/new'
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'pass'
      fill_in 'user_password_confirmation', with: 'pass'
      click_button 'Submit'

      expect(page).to have_content 'signup fail'
    end
  end
end
