Given(/^a requirements file with a dependency "(.*?)"$/) do |dependency|
  @user = ::DSL::User.new
  @user.create_python_app dependency
end

Given(/^a requirements file with a dependency "(.*?)" in a virtualenv$/) do |dependency|
  @user = ::DSL::User.new
  @user.create_python_virtualenv dependency
end
