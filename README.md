# CSR Database

This is my final project for the Rails section of the Flatiron School.  It was
created to be a tool that can improve my own workflow at my current employer and
consists of a Customer Database to track Static IP assignment.

## Usage

To use this app you need to clone down the repository and then run `bundle
install` to ensure you have all the proper gems installed and ready to use.
Once complete you will need to run `rake db:create db:migrate` to setup the
database and then you run `rake db:seed` if you with to use my example seed data
or you can use that as a template and create your own seed data. After the seed
process is complete you can use `rails s` to start the rails server on port 3000

## Submitting a Pull Request to Suggest an Improvement

If you see an opportunity for improvement and can make the change yourself go
ahead and use a typical git workflow to make it happen:

* Fork this repository
* Make the change on your fork, with descriptive commits in the standard format
* Open a Pull Request against this repo

## License

The is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
