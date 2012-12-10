namespace :dev do

  desc "Populates the db with dev data."
  task :populate => "app:configure" do

    puts "Creating dummy users and courses..."
    User.create!(first_name: "Admin",
                 last_name:  "Aardvark",
                 email:      "a@a.a",
                 password:   "password",
                 password_confirmation: "password"
                ).toggle!(:admin)

    10.times do |n|
      user = User.create!(first_name: "First#{n+1}",
                   last_name:  "Last#{n+1}",
                   email:      "a#{n+1}@a.a",
                   password:   "password",
                   password_confirmation: "password"
                  )
      course = Course.create!(name:  "Course #{n+1}",
                              title: "COUR 00#{n+1}",
                              section: "01",
                              term:  Date.new(Date.today.year, 8, 1),
                              teacher_id: n+1
                             )
      course.users << user
    end
    puts "Creating dummy surveys, polls, and answers..."
    Course.all.each do |course|
      survey = course.surveys.create!(name: "Test survey", total_points: 30)
      3.times do |n|
        poll = survey.polls.create(question_text: "Test question #{n}?",
                                   answer_type: "Multiple Choice",
                                   is_radio: "Yes",
                                   points: 10
                                  )
        3.times do |n|
          poll.answers.create(answer_text: "Test answer #{n}",
                              is_right: true,
                             )
        end
      end
    end
  end
end

