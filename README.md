# User System

Our user system allows user to sign up, log in, log out, modify profile and reset password.

## Developer Setup

1. Install Ruby 2.4.3
2. Install Bundler to manager dependencies: `gem install bundler`
3. Setup the database: `bundle exec rake db:migrate`
4. Start the application: `bundle exec rails s`
5. Run rspec `rspec`

## Gems

1. letter_opener - for sending email
2. rspec-rails - for test
3. capybara-email - for test
4. bcrypt - for hashing password

## User Story

1. As a user, I can visit sign up page and sign up with my email (with valid format and unique in database) and password (with confirmation and at least eight characters).
2. When I sign up successfully, I would see my profile page.
3. When I sign up successfully, I would receive a welcome email.
4. When I sign up incorrectly, I would see an error message in the sign-up page.
5. As a user, I can edit my username and password in the profile page. I can also see my email on the page but I can not edit it.
6. When I first time entering the page, my username would be my email prefixing, e.g. (email is "user@example.com", username would be "user")
7. When I edit my username, it should contain at least five characters. (Default username does not have this limitation)
8. As a user, I can log out the system.
9. When I log out, I would see the login page.
10. As a user, I can visit the login page and log in with my email and password.
11. As a user, I can visit the login page and click "forgot password" if I forgot my password.
12. When I visit forgot password page, I can fill my email and ask the system to send reset password email.
13. As a user, I can visit reset password page from the link inside reset password email and reset my password (with confirmation and at least eight characters).
14. The link should be unique and only valid within six hours.
