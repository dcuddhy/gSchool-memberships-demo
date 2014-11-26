User.delete_all
Project.delete_all
Task.delete_all

15.times do
  users = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

6.times do
  Project.create!(name: Faker::Company.name)
end
