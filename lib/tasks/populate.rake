namespace :dev do

  desc "Populates the db with dev data."
  task :populate => "app:configure" do

    puts "Creating dummy users..."
    User.create!(first_name: "Admin",
                 last_name:  "Aardvark",
                 email:      "a@a.a",
                 password:   "password",
                 password_confirmation: "password"
                ).toggle!(:admin)

    10.times do |n|
      User.create!(first_name: "Test#{n}",
                   last_name:  "User#{n}",
                   email:      "a#{n}@a.a",
                   password:   "password",
                   password_confirmation: "password"
                  )
    end
    puts "Creating Courses"
    10.times do |n|
      Course.create!(name:  "Course #{n}",
                     title: "COUR 00#{n}",
                     section: "01",
                     term:  Date.new(Date.today.year, 8, 1),
                     teacher_id: n+1
                    )
    end
  end
end

