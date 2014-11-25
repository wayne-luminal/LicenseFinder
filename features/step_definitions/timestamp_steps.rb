require 'timecop'

@html_timestamp = nil

Then(/^I note the timestamp from the html$/) do
  @user.in_html do |html|
    @html_timestamp = html.find(".timestamp").text
  end
end

And(/^I wait 10 minutes$/) do
  # TODO: remember to return the clock to sane state
  puts Time.now
  sleep 60
  # Timecop.travel(Time.now + (10 * 60))
  puts Time.now
end

Then(/^the timestamp should not have changed$/) do
  new_html_timestamp = @user.in_html do |html|
    html.find(".timestamp").text
  end
  expect(@html_timestamp).to eq(new_html_timestamp)
end

Given(/^an actual ruby project$/) do
  @user = ::DSL::User.new
  @user.create_ruby_app
end
