p1 = Production.create(title: 'Hamlet', genre: 'drama', director:'Bill Shakespeare', description:'The Tragedy of Hamlet, Prince of Denmark', budget: 100000.00, image:'https://upload.wikimedia.org/wikipedia/commons/6/6a/Edwin_Booth_Hamlet_1870.jpg', ongoing:true)
p2 = Production.create(title: 'cats', genre: 'musical', director:'Andrew Lloyd Webber', description:' Jellicles cats sing and dance', budget: 200000.00, image:'https://upload.wikimedia.org/wikipedia/en/3/3e/CatsMusicalLogo.jpg', ongoing:true)


ProductionRole.create(role:'Hamlet', understudy:true, production: p1)

u1 = User.create(name:'ix', email:'email@email.com')
u2 = User.create(name:'rose', email:'rose@cutecats.com')


Ticket.create(user:u1, production:p2, price:65.00)
Ticket.create(user:u2, production:p2, price:65.00)
Ticket.create(user:u2, production:p1, price:65.00)