# sample-login-watir-cucumber

This is an example of Acceptance Test Driven Development (ATDD) using
[Watir](http://watir.com), [Cucumber](https://cucumber.io), [Ruby](https://www.ruby-lang.org).

**However, it also provides a somewhat extensible framework that can be reused
by replacing the existing tests.**

These tests show how to use Watir-Cucumber to verify...
* The ability to login as a user
* That critical elements are on a page

It also demonstrates the basic features of the
Watir-Cucumber framework and how they can be extended.

## Run Locally or in Containers
This project can be run...
* Locally containerized in 2 separate Docker containers:
  one containing the tests, the other the browser
* Locally natively running the tests against a local browser
  or a containerized browser

## Contents of this Framework
This framework contains support for...
* Using Selenium Standalone containers eliminating the need
  for locally installed browsers or drivers
* Multiple local browsers with automatic driver management
* Single-command docker-compose framework to run
  the tests or a supplied command
* Local through fully-containerized execution
* Containerized development environment
* Continuous Integration with GitHub Actions vetting
  linting, static security scanning, and functional
  tests

## To Run the Automated Tests in Docker
The easiest way to run the tests is with the docker-compose
framework using the `dockercomposerun` script.

This will build a docker image of this project and run
the tests against a
[Selenium Standalone](https://github.com/SeleniumHQ/docker-selenium)
container.

You can view the running tests, using the included
Virtual Network Computing (VNC) server.

### Prerequisites
You must have Docker installed and running on your local machine.

### To See the Tests Run Using the VNC Server
> Browsers in the containers are not visible in the VNC server
  when running `headless`.

The Selenium Standalone containers used in the docker-compose
framework have an included VNC server for viewing and
debugging the tests.

You can use either a VNC client or a web browser to view the tests.

1. Ensure that you are running the Selenium Standalone containers
   (e.g. in the docker-compose framework)
2. To view the tests... using a web browser, navigate to
   http://localhost:7900/; or to use a VNC server, use
   `vnc://localhost:5900` (On Mac you can simply enter
   this address into a web browser)
3. When prompted for the (default) password, enter `secret`

For more information, see the Selenium Standalone Image
[VNC documentation](https://github.com/SeleniumHQ/docker-selenium#debugging)

### To Run Using the Default Chrome Standalone Container
1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script with the defaults...

   ```
   ./script/dockercomposerun
   ```

### To Run Using the Firefox Standalone Container
1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script setting the `BROWSER` and `SELENIUM_IMAGE`
   environment variables to specify Firefox...
   ```
   BROWSER=firefox SELENIUM_IMAGE=selenium/standalone-firefox ./script/dockercomposerun
   ```

### To Run the Test Container Interactively (i.e. "Shell In")
1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script and supply the shell command `sh`...
   ```
   ./script/dockercomposerun sh
   ```
3. Run desired commands in the container
   (e.g. `bundle exec rake`)
4. Run the exit command to exit the Test container
   ```
   exit
   ```
## To Run the Automated Tests Natively
Assuming that you have a Ruby development environment,
the tests either can be run directly by the Cucumber
runner or by the supplied Rakefile.

### Prerequisites
* Ruby 2.7.4
* To run the tests using a specific browser requires that browser
be installed
(e.g. to run the tests in the Chrome Browser requires
Chrome be installed).

1. Install bundler (if not already installed for your Ruby):
   ```
   $ gem install bundler
   ```
2. Install gems (from project root):
   ```
   $ bundle install
   ```

### Examples of Running the Tests
#### Defaults
```
bundle exec rake
```

```
bundle exec cucumber
```
#### Browsers
```
BROWSER=chrome bundle exec rake
```
```
BROWSER=firefox_headless bundle exec cucumber
```

### Environment Variables
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

#### Using the Selenium Standalone Containers
Like the docker-compose framework, these tests can be run natively
using the Selenium Standalone containers and the VNC Server
if you want.

For specifics, see the Selenium Standalone Image
[documentation](https://github.com/SeleniumHQ/docker-selenium).

**Example of Using the Selenium Standalone (Chrome) Container...**
1. Run the Selenium Standalone image with standard port and volume mapping...
   ```
   docker run -d -p 4444:4444 -p 5900:5900 -p 7900:7900 -v /dev/shm:/dev/shm selenium/standalone-chrome
   ```
2. If you want, launch the VNC client in app or browser
3. Run the tests specifying the remote Selenium container...
   ```
   REMOTE='http://localhost:4444/wd/hub' BROWSER=chrome bundle exec cucumber
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
2. Run the development environment image either on its own or
   in the docker-compose environment with either the Selenium Chrome
   or Firefox container.  By default the development environment
   container executes the `/bin/ash` shell providing a command
   line interface. When running the development environment
   container, you must specify the path to this project's
   source code.

#### Running Just the Test Development Image
To run the development environment on its own, use
`docker run`...
```
docker run -it --rm -v $(pwd):/app browsertests-dev
```

#### Running the Test Development Image in docker-compose
To run the development environment in the docker-compose environment,
with a Selenium Standalone container use the `dockercomposerun`
script and run it interactively with the default shell `/bin/ash`...
```
BROWSERTESTS_IMAGE=browsertests-dev BROWSERTESTS_SRC=${PWD} ./script/dockercomposerun /bin/ash
```

## Sources and Additional Information
* The [Page-Object gem](https://rubygems.org/gems/page-object)
* The [Webdrivers gem](https://github.com/titusfortner/webdrivers)
* The [Selenium Docker Images](https://github.com/SeleniumHQ/docker-selenium)
