friends = Friend.create([{ first_name: 'yo', last_name: 'Man', twitter: '@realDonaldTrump', email: 'ikno2@gmail.com' }, { first_name: 'yo', last_name: 'Man', twitter: '@realDonaldTrump', email: 'ikno3@gmail.com' }])


friends.each do |friend|
  20.times do |i|
    borrow = i % 2 == 0 ? "borrowed" : "returned"
    friend.articles.create({state: borrow, description: "#{i}"})
  end
end

