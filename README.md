ResponseMonster! [![Build Status](https://secure.travis-ci.org/bafipawi/ResponseMonster.png?branch=master)](http://travis-ci.org/bafipawi/ResponseMonster)
================

ResponseMonster is an attempt to replace classroom-based [audience response][1]
systems with open source software on both ends. ResponseMonster is primarily a
web-based application.

How it works
------------
One ResponseMonster server handles any number of teachers, students, and
classes. Teachers can set up questions to be answered ahead of time or
on-the-spot. A maximum of one question per class can be opened at a time; when
the question closes, response data can be viewed by the teacher and optionally
publicized to students. Surveys can be anonymous.

The application runs on Ruby on Rails and uses an SQLite database to store
surveys and responses. Each class has one teacher and many students.

ResponseMonster will be designed to handle multiple choice questions, but short
answer questions may be implemented somewhere down the road.

[1]: http://en.wikipedia.org/wiki/Audience_response

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
* ex: it { should respond_to(:first_name) }
- Code that extends past a reasonable amout of space should get split up into multiple lines
* ex: 
    before { @user = User.new(first_name: "Test",
							  last_name: "User",
							  email: "test@test.com",
							  password: "password",
							  password_confirmation: "password")  }