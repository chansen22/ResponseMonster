ResponseMonster! [![Build Status](https://secure.travis-ci.org/bafipawi/ResponseMonster.png?branch=master)](http://travis-ci.org/bafipawi/ResponseMonster)
================

ResponseMonster is an attempt to replace classroom-based [audience response][1]
systems with open source software on both ends. ResponseMonster is primarily a
web-based application.

How it works
------------
One ResponseMonster server handles any number of teachers, students, and
classes. Teachers can set up questions to be answered ahead of time or
on-the-spot. A maximum of one question per class can be opened for responses at
a time; when the question closes, response data can be viewed by the teacher and
optionally publicized to students. Surveys can be anonymous.

The application runs on Ruby on Rails and uses an SQLite database to store
surveys and responses. Each class has one teacher and many students.

ResponseMonster will be designed to handle multiple choice questions, but short
answer questions may be implemented somewhere down the road. There is also a
possibility of having code answers be submitted which are compiled on the server
and the output is returned to the teacher. These answers can be saved, along
with the generated output, which can then be inspected by the teacher.

User interface
--------------
Each ResponseMonster class has a web page of its own.

Teachers who visit the class page will have the option to select a previously
entered question to open for responses, as well as the option to enter a new
question that should be opened for responses immediately. They can also view
data for any previously opened questions.

Students who visit the class page will be presented with the class's current
open question if one exists. The available answers to this question are listed
below, and the student uses a form to choose one and submit their response.
Below this area is a list of previously answered questions. Each previously
opened question is accompanied by the class-wide data for that question, if the
teacher chooses to make it available.

Class structure
---------------
A class has one teacher and many students. The ability to add, edit, and
open/close questions for a class belongs only to the teacher for that class. The
teacher also holds the ability to make questions private, not private,
anonymous, and not anonymous.

A class has a name (e.g. "CSCI 430") and a title (e.g. "Software Engineering").
Each of these fields will have a corresponding index in order to allow for easy
searching.

[1]: http://en.wikipedia.org/wiki/Audience_response

Devices supported
-----------------
Initially, ResponseMonster will be built for laptop browsers. Applications for
smartphones and other mobile devices are planned to come soon after, built most
likely using [WebView][3]. After support for these devices is finalized, we plan
on taking the next step either into SMS territory, allowing students to send in
responses using text messages, or into an attempt to reverse engineer the modern
clicker device in order to allow it to operate as a ResponseMonster response
device. An SMS response system is the more realistic option after considering
that support for clickers would require a desktop application and a hardware
reciever.

[3]: http://developer.android.com/reference/android/webkit/WebView.html

Survey data
-----------
Response data for each question is stored until a teacher decides to remove it.
By default, response data is considered private -- only the teacher of the class
the data was collected for may view it. If a teacher decides to make response
data for a question public, students of that class may then view the data.

Teachers may also mark a question as anonymous. ResponseMonster will not record
any identifying information sent in response to an anonymous question.

The default view for response data is a pie chart generated using
[Highcharts][2], a JavaScript library. Users may also view raw, tabular data
for a response.

[2]: http://www.highcharts.com/

Administration
--------------
ResponseMonster has one administration role. This role has the ability to view,
modify, and delete users, classes, and questions without being given permission.
In addition, it has the ability to grant other accounts the administration role.
On its first run, ResponseMonster sets up one administrator account. The
granting of the administrator role to further accounts should be done with
caution and forethought.

Features
========

Things that will definitely be implemented
------------------------------------------

Things that will hopefully be implemented
-----------------------------------------
* The ability for teachers to preset a time window for a survey to be open
  during (i.e. online quizzes)

Running ResponseMonster
=======================

Installation
-------------

- `git clone git@github.com:bafipawi/ResponseMonster`
- `cd ResponseMonster`
- `bundle install`
- `rake db:migrate`

Testing
--------

- `rake db:test:prepare`
- `guard`

Code standards
--------------

- Camel case variables
- Variables should be as descriptive as they need to be
- There should be one blank line between methods
- There should be no spaces after an opening paren and no spaces before a closing paren
- There should be a space after an opening { and a space before a }
- {'s should start on the same line that the block they describe starts on.
* ex: 
    it { should respond_to(:first_name) }
- Code should be attempted to be wrapped at column 80
* ex:

```ruby
before { @user = User.new(first_name: "Test",
                          last_name: "User",
                          email: "test@test.com",
                          password: "password",
                          password_confirmation: "password") }
```

Software Development Risks
--------------------------
1.	Users (Difficulty of using application, users don't have laptops/smartphones, etc)
Priority Level: 1
Level of Impact: 1
How to Mitigate: Reverse engineer a clicker for cheaper production
Likelihood: 1

2.	Incorrect estimation of completion time.  This would affect the quality of the final product.
Priority Level: 8
Level of Impact: 8
How to Mitigate: Constantly reassess our progress and evaluate our goals accordingly.
Likelihood: 3

3.	Ability to learn “Ruby on Rails”. The learning curve could be challenging for us.
Priority Level: 8
Level of Impact: 7
How to Mitigate: Keep up on tutorials and reading.
Likelihood: 2

4.	Not enough testing, software could have bugs at release.
Priority Level: 6
Level of Impact: 6
How to Mitigate: Test frequently and often, especially after new implementations of key elements.
Likelihood: 4

5.	Not enough features after completion.
Priority Level: 10
Level of Impact: 10
How to Mitigate: Keep work/motivation up throughout the semester.
Likelihood: 2

6.	No professional design experience.
Priority Level: 1
Level of Impact: 1
How to Mitigate: Keep astestics simple.
Likelihood: 1

7.	Application not being used.
Priority Level: 8
Level of Impact: 7
How to Mitigate: Keep application user friendly and design simple.
Likelihood: 5

8.	Planning unnecessary features that may not be used. 
Priority Level: 6
Level of Impact: 6
How to Mitigate: We shouldn’t try to anticipate what we need, before we need it.
Likelihood: 5

9.	Schoolwork load becomes too heavy.
Priority Level: 6
Level of Impact: 10
How to Mitigate: Stay on track with school and manage time.
Likelihood: 2

10.	Members not working together/getting along.
Priority Level: 2
Level of Impact: 8
How to Mitigate: Be team players.
Likelihood: 1

REQUIREMENTS
------------
1. Ability for teachers to administer Surveys they have previously created.

2. Ability for teachers to create questions on the fly

3. Ability for users to take Surveys

4. Ability to create "Courses" to select groups of users to administer surveys to.

5. Ability for Administrators to create teachers

6. Ability to instantly see results of a user's survey

7. Ability to administer both multiple choice and short answer questions

8. Ability for teachers to be able to see statstics for each student's responses

9. Ability for users to see statistics on their own responses

USE CASES
---------
1. User login

2. User navigating to a specific Course page out of a list of the classes they are taking

3. Course signup page - page for user to add a Course to their current Courses

4. Course page - contains current open surveys and old surveys with responses. Also has administration/teaching options on it if you are currently an admin or teaching the class.
