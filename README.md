ResponseMonster!
================

ResponseMonster is an attempt to replace classroom-based [audience response][1]
systems with open source software on both ends. ResponseMonster is primarily a
web-based application.

How it works
------------
One ResponseMonster server handles any number of teachers, students, and
classes. Teachers can set up questions to be answered ahead of time or
on-the-spot. One question per class can be opened for responses at a time; when
the question closes, response data can be viewed by the teacher and optionally
publicized to students.

The application runs on Ruby on Rails and uses an SQLite database to store
surveys and responses. Each class has one teacher and many students.

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
