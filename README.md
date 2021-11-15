# sample-login-watir-cucumber

This is an example of Acceptance Test Driven Development (ATDD) using
[Watir](http://watir.com), [Cucumber](https://cucumber.io), [Ruby](https://www.ruby-lang.org).
**However, it also provides a somewhat extensible framework that can be reused
by replacing the existing tests.**

These tests show how to use Watir-Cucumber to verify...
* That critical elements are on a page
* The ability to login as a user

It also demonstrates the basic features
of the Watir-Cucumber framework and how they can be extended.

### Run Locally or in Containers
This project can be run...
* Fully locally running the tests against a local browser
* Locally running the tests against a containerized browser
* Fully in 2 separate Docker containers, one containing the
tests the other the browser

### Contents of this Framework
This framework contains support for...
* Local thru fully containerized execution
* Using Selenium Standalone containers eliminating the need for locally installed browsers or drivers
* Multiple local browsers with automatic driver management

## To Run the Automated Tests in Docker
The tests in this project can be run be run fully in Docker
assuming that Docker is installed and running.  This will build
a docker image of this project and execute the tests against
a Selenium Standalone container.

### Prerequisites
You must have docker installed and running on your local machine.

### To Run Fully in Docker
#### To Run Using the Default Chrome Standalone Container
1. Ensure Docker is running
2. Run the project docker-compose.yml file with the
   docker-compose.selenium.yml file (this runs using the Chrome
   standalone container)
```
docker-compose -f docker-compose.yml -f docker-compose.selenium.yml up
```

#### To Run Using the Firefox Standalone Container
1. Ensure Docker is running
2. Run the project docker-compose.yml file with the
   docker-compose.selenium.yml file and specify the Firefox container
   with environment variables
```
BROWSER=firefox SELENIUM_IMAGE=selenium/standalone-firefox docker-compose -f docker-compose.yml -f docker-compose.selenium.yml up
```

## To Run the Automated Tests Locally
The tests either can be run directly by the Cucumber runner or by the
supplied Rakefile.

### Examples ###
#### Defaults ####
```
bundle exec rake
```
```
bundle exec cucumber
```
#### Browsers ####
```
BROWSER=chrome bundle exec rake
```
```
BROWSER=firefox_headless bundle exec cucumber
```

### To Run Using Rake
To run the automated tests using Rake, execute...

*command-line-arguments* `bundle exec rake`

### To Run Using Cucumber
To run the automated tests using Cucumber, execute...

*command-line-arguments* `bundle exec cucumber`

### Command Line Arguments
#### Specify Remote (Container) URL
`REMOTE=`...

Specifying a Remote URL creates a remote browser of type
specified by `BROWSER` at the specified remote URL  

 **Example:**
`REMOTE='http://localhost:4444/wd/hub'`

#### Specify Browser
`BROWSER=`...

* Mostly, this uses a pass thru and convert to symbol approach
  * **example:** "chrome" converts to `:chrome` which is a Watir browser
* Headless browsers are handled by detecting the word "headless"
and sending that as an argument to the browser specified
  * **example:** "chrome_headless" converts to `:chrome`
  with `headless` argument

#### Browser Drivers
This project uses the
[Webdrivers](https://github.com/titusfortner/webdrivers)
gem to automatically download and maintain chromedriver and
geckodriver (Firefox).

#### Supported Browsers
The following browsers were working on Mac at the time of this commit:
* `chrome` - Google Chrome (requires Chrome)
* `chrome_headless` - Google Chrome run in headless mode (requires Chrome > 59)
* `firefox` - Mozilla Firefox (requires Firefox)
* `firefox_headless` - Mozilla Firefox (requires Firefox)
* `safari` - Apple Safari (requires Safari)

### To Run Using the Selenium Standalone Debug Containers
These tests can be run using the Selenium Standalone Debug containers for both
Chrome and Firefox.  These *debug* containers run a VNC server that allow you to see
the tests running in the browser in that container.  These Selenium Standalone Debug containers
must be running on the default port of `4444`.

For more information on these Selenium Standalone Debug containers see https://github.com/SeleniumHQ/docker-selenium.

#### Prerequisites
You must have docker installed and running on your local machine.

To use the VNC server, you must have a VNC client on your local machine (e.g. Screen Sharing application on Mac).

#### To Run Using Selenium Standalone Chrome Debug Container
1. Ensure Docker is running on your local machine
2. Run the Selenium Standalone Chrome Debug container on the default ports of 4444 and 5900 
for the VNC server
```
docker run -d -p 4444:4444 -p 5900:5900 -v /dev/shm:/dev/shm selenium/standalone-chrome-debug:latest
```
3. Wait for the Selenium Standalone Chrome Debug container to be running (e.g. 'docker ps')
4. Run the tests specifing the `REMOTE` and using the `chrome` or `chrome_headless` browser
   specification
```
REMOTE='http://localhost:4444/wd/hub' BROWSER=chrome bundle exec cucumber
```

#### To Run Using Selenium Standalone Firefox Debug Container
1. Ensure Docker is running on your local machine
2. Run the Selenium Standalone Firefox Debug container on the default ports of 4444 and 5900 
for the VNC server
```
docker run -d -p 4444:4444 -p 5900:5900 -v /dev/shm:/dev/shm selenium/standalone-firefox-debug:latest
```
3. Wait for the Selenium Standalone Firefox Debug container to be running (e.g. 'docker ps')
4. Run the tests specifying the `REMOTE` and using the `firefox` or `firefox_headless` browser
   specification
```
REMOTE='http://localhost:4444/wd/hub' BROWSER=firefox_headless bundle exec cucumber
```

#### To See the Tests Run Using the VNC Server
1. Connect to [vnc://localhost:5900](vnc://localhost:5900) (On Mac you can simply enter this address into a Browser)
2. When prompted for the (default) password, enter `secret`

**NOTE:** Browsers in the containers are not visible in the VNC server when `headless`.

### Requirements
* Ruby 2.7.4
* To run the tests using a specific browser requires that browser
be installed
(e.g. to run the tests in the Chrome Browser requires
Chrome be installed).

Install bundler (if not already installed for your Ruby):

```
$ gem install bundler
```

Install gems (from project root):

```
$ bundle
```

## Development
This project can be developed locally or using the supplied basic,
container-based development environment which include `vim` and `git`.

### To Develop Using the Container-based Development Environment
To develop using the supplied container-based development environment...
1. Build the development environment image specifying the `devenv` build
   stage as the target and supplying a name (tag) for the image.
```
docker build --no-cache --target devenv -t browsertests-dev .
```
2. Run the built development environment image either on its own or
in the docker-compose environment with either the Selenium Chrome
or Firefox container.  By default the development environment container
executes the `/bin/ash` shell providing a command line interface. When
running the development environment container, you must specify the path
to this project's source code.

To run the development environment on its own, use `docker run`...
```
docker run -it --rm -v $(pwd):/app browsertests-dev
```

To run the development environment in the docker-compose environment,
use the `docker-compose.dev.yml` file...
```
IMAGE=browsertests-dev SRC=${PWD} docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.selenium.yml run browsertests /bin/ash
```

## Additional Information
These tests use the [page-object gem](https://rubygems.org/gems/page-object)
