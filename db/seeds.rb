User.create(name: "Sarko",email: "chablatech@gmail.com",password: "Sarkodisen22", role: true)

5.times do |n|
    name = "User number " + n.to_s
    email = "user" + n.to_s + "@gmail.com"
    password = "mypassword"
    User.create!(name: name,
                email: email,
                password: password)
end

5.times do |n|
    user_id = 1
    content = "content" + n.to_s
    Post.create!(user_id: user_id,
    content: content)
end


5.times do |n|
    post_id = 1
    user_id = 1
    content = "content" + n.to_s
    Comment.create!(post_id: post_id,
    user_id: user_id, content: content)
end
