Given(/^I visit the homepage$/) do
  visit '/'
end

And(/^enter some coordinates$/) do
  fill_in('to_place', with: 'A1')
end

When(/^I press place$/) do
  click_button('place')
end

Then(/^i should see 'ship placed!'$/) do
  expect(page).to have_content('ship placed!')
end

Given(/^i enter coordinates of a ship$/) do
  fill_in('to_fire_at', with: 'A1')
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
  expect(page).to have_content('miss!')
end

Then(/^i should be able to fire again$/) do
  fill_in('to_fire_at', with: 'A1')
  click_button('fire again!')
  expect(page).to have_content('hit!')
end