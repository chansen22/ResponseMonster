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

Teachers who visit their class page will have the option to select a previously
entered question to open for responses, or to enter in a new question that
should be opened immediately. They can also view data for previously opened
questions.

Students who visit the class page will be presented with the class's open
question if one exists, and a list of previously answered questions below it.
Each previously opened question is accompanied by the answer that the student gave, 
and the class-wide data for that question, if the teacher chooses to make it 
available.

The application runs on Ruby on Rails and uses an SQLite database to store
surveys and responses. Each class has one teacher and many students.

ResponseMonster will be designed to handle multiple choice questions, but short
answer questions may be implemented somewhere down the road. There is also a 
possibility of having code answers be submitted which are compiled on the server
and the output is returned to the teacher. These answers can be saved, along with
the generated output, which can then be inspected by the teacher.

The class page will have all the questions the teacher has saved on it as well
as a spot to make a new question.  After a question has been answered by a
class, the view for the question will change on the class page.  It will be
accompanied by a link to some data about the question.  Which students answered
which way and a few charts about how the data is laid out.  Described further 
in Survey Data.  Each class has a field for a class name and a spot for the 
class title.  The name being something like "Software Engineering" and the 
title being "Csci 430".  Both the title and the name will have an index on 
them so it will be easy to search for one or the other as a student looking 
for their classes.

[1]: http://en.wikipedia.org/wiki/Audience_response

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

Installation:
=============

- git clone git@github.com:bafipawi/ResponseMonster
- cd ResponseMonster
- bundle install
- rake db:migrate

Testing:
========

- rake db:test:prepare
- guard

Code Standards
==============

- Camel case variables
- Variables should be as descriptive as they need to be
- There should be one blank line between methods
- There should be no spaces after an opening paren and no spaces before a closing paren
- There should be a space after an opening { and a space before a }
- {'s should start on the same line that the block they describe starts on.
* ex: 
    it { should respond_to(:first_name) }
- Code that extends past a reasonable amout of space should get split up into multiple lines
* ex: 
    before { @user = User.new(first_name: "Test",
							  last_name: "User",
							  email: "test@test.com",
							  password: "password",
							  password_confirmation: "password")  }
