
Restaurant.create([{ name: 'DoDo' }, { name: 'Mario' }, { name: 'Chezare' }])

User.create(email: 'dodo@email.ru', restaurant: Restaurant.first, role: 'member', password: 'qweqwe', password_confirmation: 'qweqwe')
User.create(email: 'admin@email.ru', role: 'admin', password: 'qweqwe', password_confirmation: 'qweqwe')

Restaurant.all.each do |restaurant|
  2.times{ restaurant.points.create(name: "Точка #{rand(100)}") }
end