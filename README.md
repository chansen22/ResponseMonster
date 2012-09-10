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

- git clone git@github.com:bafipawi/ResponseMonster
- cd ResponseMonster
- bundle install
- rake db:migrate

Testing
--------

- rake db:test:prepare
- guard

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
```before { @user = User.new(first_name: "Test",
												  last_name: "User",
												  email: "test@test.com",
												  password: "password", 
												  password_confirmation: "password")  }```
