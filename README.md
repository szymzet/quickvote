# Quickvote - simple poll creator

http://szymzet.com/quickvote

Small and simple application aimed for gaining experience using Rails and some
good Ruby and Rails practices. The application has a 100% test coverage and tries
to stick with Sandi Metz's 4 rules:

* Your class can be no longer than 100 lines of code.
* Your methods can be no longer than five lines of code.
* You can pass no more than four parameters and you can’t just make it one big hash.
* When a call comes into your Rails controller, you can only instantiate one object to do whatever it is that needs to be done.

The development was driven by tests with an outside in approach (starting
with integration tests and adding unittests if needed).
