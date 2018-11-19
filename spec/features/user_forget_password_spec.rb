require 'rails_helper'

describe 'the forget password process', type: :feature do
  let!(:user) { User.create(email: 'user@example.com', password: 'password') }

  feature 'user can reset password' do
    scenario 'reset password throut forget password' do
      visit 'sessions/new'

      expect(page).to have_content 'Forgot Password'

      click_link 'Forgot Password'

      expect(page).to have_content 'Forgot Password Page'

      fill_in 'email', with: user.email
      click_button 'Submit'

      expect(page).to have_content 'Welcome To Login Page'

      open_email(user.email)

      expect(current_email.to).to eq [user.email]
      expect(current_email.subject).to eq 'Reset Password'
      expect(current_email).to have_content 'Reset Password'

      current_email.click_link 'Reset Password'

      expect(page).to have_content 'Reset Password'

      fill_in 'user_password', with: 'new_password'
      fill_in 'user_password_confirmation', with: 'new_password'
      click_button 'Submit'

      expect(page).to have_content 'Welcome To Login Page'

      fill_in 'email', with: user.email
      fill_in 'password', with: 'new_password'
      click_button 'Submit'

      expect(page).to have_content 'Welcome To profile Page'
    end
  end
end
