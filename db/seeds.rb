10.times do
  name = Faker::Name.title
  Category.create name: name
end
