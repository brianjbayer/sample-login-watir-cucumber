# sample-login-watir-cucumber

This is an example 
[Watir](http://watir.com)-[Cucumber](https://cucumber.io)-[Ruby](https://www.ruby-lang.org)
implementation of Acceptance Test Driven Development (ATDD).
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
1. Ensure Docker is running
2. Run the project docker-compose.yml file (this runs using the Chrome
standalone container)
```
docker-compose up
```

#### To Run Using the Firefox Standalone Container
2. Run the project docker-compose.yml file (this runs using the Firefox
   standalone container
```
docker-compose -f docker-compose.firefox.yml up
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
SPEC_BROWSER=chrome bundle exec rake
```
```
SPEC_BROWSER=firefox_headless_container bundle exec cucumber
```

### To Run Using Rake
To run the automated tests using Rake, execute...

*command-line-arguments* `bundle exec rake`

### To Run Using Cucumber
To run the automated tests using Cucumber, execute...

*command-line-arguments* `bundle exec cucumber`

### Command Line Arguments
#### Specify Browser
`SPEC_BROWSER=`...

* Mostly, this uses a pass thru and convert to symbol approach
  * **example:** "chrome" converts to `:chrome` which is a Watir browser
* Headless browsers are handled by detecting the word "headless"
and sending that as an argument to the browser specified
  * **example:** "chrome_headless" converts to `:chrome`
  with `headless` argument
* Container based browsers are handled by detecting the word "container"

#### Browser Drivers
This project uses the
[Webdrivers](https://github.com/titusfortner/webdrivers)
gem to automatically download and maintain chromedriver and
geckodriver (Firefox).

#### Supported Browsers
The following browsers were working on Mac at the time of this commit:
* `chrome` - Google Chrome (requires Chrome)
* `chrome_headless` - Google Chrome run in headless mode (requires Chrome > 59)
* `chrome_container` - Selenium Standalone Chrome Debug container (requires this container 
to be already running on the default ports)
* `chrome_headless_container` - Selenium Standalone Chrome Debug container (requires this container 
to be already running on the default ports)
* `firefox` - Mozilla Firefox (requires Firefox)
* `firefox_headless` - Mozilla Firefox (requires Firefox)
* `firefox_container` = Selenium Standalone Chrome Debug container (requires this container 
to be already running on the default ports)
* `firefox_headless_container` = Selenium Standalone Chrome Debug container (requires this container 
to be already running on the default ports)
* `safari` - Apple Safari (requires Safari)


*R.I.P.* `phantomjs` - PhantomJS headless browser is no longer supported by Watir
(although I can no longer seem to find the link)

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
4. Run the tests using the `chrome_container`
```
SPEC_BROWSER=chrome_container bundle exec cucumber
```

#### To Run Using Selenium Standalone Firefox Debug Container
1. Ensure Docker is running on your local machine
2. Run the Selenium Standalone Firefox Debug container on the default ports of 4444 and 5900 
for the VNC server
```
docker run -d -p 4444:4444 -p 5900:5900 -v /dev/shm:/dev/shm selenium/standalone-firefox-debug:latest
```
3. Wait for the Selenium Standalone Firefox Debug container to be running (e.g. 'docker ps')
4. Run the tests using the `firefox_container`
```
SPEC_BROWSER=firefox_headless_container bundle exec cucumber
```

#### To See the Tests Run Using the VNC Server
1. Connect to [vnc://localhost:5900](vnc://localhost:5900) (On Mac you can simply enter this address into a Browser)
2. When prompted for the (default) password, enter `secret`

**NOTE:** Browsers in the containers are not visible in the VNC server when `headless`.

### Requirements
* Ruby 2.6.3
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

## Additional Information
These tests use the [page-object gem](https://rubygems.org/gems/page-object)
