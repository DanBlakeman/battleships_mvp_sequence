Given(/^I visit the homepage$/) do
  visit '/'
end

And(/^enter some coordinates$/) do
  fill_in('place_ship_1', with: 'A1')
  fill_in('place_ship_2', with: 'B1')
  fill_in('place_ship_3', with: 'C1')
end

When(/^I press place$/) do
  click_button('place')
end

Then(/^i should see 'ships placed!'$/) do
  expect(page).to have_content('ships placed!')
end

Given(/^i enter coordinates of ship "([^"]*)"$/) do |arg1|
  fill_in('to_fire_at', with: arg1)
end

When(/^I press fire$/) do
  click_button('fire')
end

Then(/^i should see 'hit'/) do
  expect(page).to have_content('hit!')
end

Given(/^i enter coordinates where no ship$/) do
  fill_in('to_fire_at', with: 'A2')
end

Then(/^i should see 'miss'$/) do
  expect(page).to have_content("Sorry dude, you've missed!")
end

Then(/^i should be able to fire again$/) do
  fill_in('to_fire_at', with: 'A1')
  click_button('fire again!')
  expect(page).to have_content('hit!')
end

Then(/^I should see my misses$/) do
  expect(page).to have_content('Your misses are: A2')
end

Then(/^i should see "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

When(/^i click "([^"]*)"$/) do |arg1|
  click_link(arg1)
end

Then(/^I should be on the homepage$/) do
  expect(page).to have_content("Welcome to Battleships, Please place your ships!")
end

