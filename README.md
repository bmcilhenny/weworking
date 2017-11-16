# Weworking

Welcome! Weworking is an interactive job search engine that provides the user with the best job results out there!

## App Guidelines

To get started, fork and clone this repository. Run `bundle install` in your terminal to install all the gems. When you are done installing, run `rake db:seed`. This will be seeding all the jobs from the Jooble database where the title includes "Software Engineer", "Project Manager", or "Developer". This will probably take 2-3 minutes. Then run `ruby bin/run.rb` in your terminal and it will start running the app. Weworking uses Jooble's publicly available API to query jobs. If you run into a 403 Error when seeding your database, you may have to request a new API Key from Jooble and change the API querying link to reflect the new API Key.

Weworking will ask you to enter your name and will subsequently ask a series of questions. At any point if you wish to start over or exit the app, you can type `start over` or `exit` and the program will act accordingly. To rerun simply reenter `ruby bin/run.rb`. For brevities sake, the number of jobs we are seeding into the database is cut in half. If you would like to get all of the jobs with titles including "Software Engineer", "Project Manager", and "Developer" go to `line 14` in the `db/seeds.rb` and remove the `/2` from the `count` variable:

`count = ((data_for_this_position["totalCount"] / 20).ceil)/2`


## Resources

* [Jooble](https://us.jooble.org/api/about)

## License

Copyright 2017 BRENDAN MCILHENNY ELLISA SHIM

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
