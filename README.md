# sample-login-watir-cucumber

This is an example of Acceptance Test Driven Development (ATDD) using
[Watir](http://watir.com), [Cucumber](https://cucumber.io),
[Ruby](https://www.ruby-lang.org).

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
* Headless execution for those browsers that support it
* Single-command docker-compose framework to run
  the tests or a supplied command
* Native through fully-containerized execution
* Containerized development environment
* Continuous Integration with GitHub Actions vetting
  linting, static security scanning, and functional
  tests
* Basic secrets management using environment variables and
  [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

## To Run the Automated Tests in Docker
The easiest way to run the tests is with the docker-compose
framework using the `dockercomposerun` script.

This will pull the latest docker image of this project and run
the tests against a
[Selenium Standalone](https://github.com/SeleniumHQ/docker-selenium)
container.

You can view the running tests, using the included
Virtual Network Computing (VNC) server.

### Prerequisites
1. You must have Docker installed and running on your local machine.
2. You must specify the login credentials (i.e. secrets) used in the
   test with the `LOGIN_USERNAME` and `LOGIN_PASSWORD` environment
   variables...
   ```
   LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword!
   ```

#### Optional: Create a `.env` File
You can create a file named `.env` in the project root directory
that contains the required environment variables that will
be used by default by Docker Compose instead of setting them on
the command line...
```
LOGIN_USERNAME=tomsmith
LOGIN_PASSWORD=SuperSecretPassword!
```

### To See the Tests Run Using the VNC Server
> Browsers in the containers are not visible in the VNC server
> when running headless

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
   LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun
   ```

### To Run Using the Firefox Standalone Container
1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script setting the `BROWSER` and `SELENIUM_IMAGE`
   environment variables to specify Firefox...
   ```
   BROWSER=firefox SELENIUM_IMAGE=selenium/standalone-firefox LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun
   ```

### To Run Using the Edge Standalone Container
1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script setting the `BROWSER` and `SELENIUM_IMAGE`
   environment variables to specify Edge...
   ```
   BROWSER=edge SELENIUM_IMAGE=selenium/standalone-edge LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun
   ```

### To Run the Test Container Interactively (i.e. "Shell In")
1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script and supply the shell command `sh`...
   ```
   LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun sh
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
* Ruby 3.2.1
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

### Environment Variables
#### Required Secrets
`LOGIN_USERNAME=tomsmith`

`LOGIN_PASSWORD=SuperSecretPassword!`

**These must be set for the login test to pass.**

> These are publicly available values but demonstrate
> basic secret management

#### Specify Browser
`BROWSER=`...

**Example:**
`BROWSER=chrome`

> **If the `BROWSER` environment variable is not provided (i.e. set),
> then the default Watir (Chrome) browser is used**

Mostly, this uses a _pass-through_ approach and should support any
valid Watir browser.

The following browsers were working on Mac at the time of this commit:
* `chrome` - Google Chrome (requires Chrome)
* `edge` - Microsoft Edge (requires Edge)
* `firefox` - Mozilla Firefox (requires Firefox)
* `safari` - Apple Safari (local only, requires Safari)

> This project uses the
> [Webdrivers](https://github.com/titusfortner/webdrivers)
> gem to automatically download and maintain chromedriver, edgedriver, and
> geckodriver (Firefox)

#### Specify Headless
`HEADLESS=`...

> **The `HEADLESS` environment variable is ignored if the `BROWSER`
> environment variable is not provided (i.e. set)**

**Example:**
`HEADLESS=true`

> The headless specification is implemented as _truthy_ (like Ruby)
> and ignores case.  Setting `HEADLESS` to any value
> including empty (i.e. `HEADLESS= `) is interpreted as `true`
> except for the value `false`.  Thus, setting `HEADLESS=FALSE`
> will **not** run headless.

#### Specify Remote (Container) URL
`REMOTE=`...

Specifying a Remote URL creates a remote browser of type
specified by `BROWSER` at the specified remote URL

 **Example:**
`REMOTE='http://localhost:4444/wd/hub'`

### Examples of Running the Tests
#### Defaults
```
LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! bundle exec rake
```

```
LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! bundle exec cucumber
```

#### Local Browsers
```
BROWSER=firefox HEADLESS=true LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! bundle exec rake
```

#### Using the Selenium Standalone Containers
Like the docker-compose framework, these tests can be run natively
using the Selenium Standalone containers and the VNC Server
if you want.

For specifics, see the Selenium Standalone Image
[documentation](https://github.com/SeleniumHQ/docker-selenium).

1. Run the Selenium Standalone image with standard port and volume mapping...
   ```
   docker run -d -p 4444:4444 -p 5900:5900 -p 7900:7900 -v /dev/shm:/dev/shm selenium/standalone-chrome
   ```
2. If you want, launch the VNC client in app or browser
3. Run the tests specifying the remote Selenium container...
   ```
   REMOTE='http://localhost:4444/wd/hub' BROWSER=chrome LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! bundle exec cucumber
   ```

## Development
This project can be developed using the supplied basic, container-based
development environment which includes `vim` and `git`.

The development environment container volume mounts your local source
code to recognize and persist any changes.

By default the development environment container executes the alpine
`/bin/ash` shell providing a command line interface.

### To Develop Using the Container-Based Development Environment
The easiest way to run the containerized development environment is with
the docker-compose framework using the `dockercomposerun` script with the
`-d` (development environment) option...
```
LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun -d
```

This will pull and run the latest development environment image of this
project along with the Chrome [Selenium Standalone](https://github.com/SeleniumHQ/docker-selenium)
container.

#### Running Just the Development Environment
To run the development environment on its own in the docker-compose
environment **without a Selenium browser**, use the `-n` option for
no Selenium and the `-d` option for the development environment...
```
LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun -n -d
```

#### Building Your Own Development Environment Image
You can also build and run your own development environment image.

1. Build your development environment image specifying the `devenv` build
   stage as the target and supplying a name (tag) for the image.
   ```
   docker build --no-cache --target devenv -t browsertests-dev .
   ```

2. Run your development environment image in the docker-compose
   environment either on its own or with the Selenium Chrome
   (or other browser containers) and specify your development
   environment image with `BROWSERTESTS_IMAGE`
   ```
   BROWSERTESTS_IMAGE=browsertests-dev LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun -n -d
   ```

#### Specifying the Source Code Location
To use another directory as the source code for the development
environment, set the `BROWSERTESTS_SRC` environment variable.
For example...
```
BROWSERTESTS_SRC=${PWD} BROWSERTESTS_IMAGE=browsertests-dev LOGIN_USERNAME=tomsmith LOGIN_PASSWORD=SuperSecretPassword! ./script/dockercomposerun -d
```

#### Running the Tests, Linting, and Security Scanning
To run the tests, linting, and security scanning in the development
environment like CI, use the `run` script.

If you are running interactively (command line) in the development
environment...

* To run the **tests**...
  ```
  ./script/run tests
  ```

* To run the **linting**...
  ```
  ./script/run lint
  ```

* To run the dependency **security scan**...
  ```
  ./script/run secscan
  ```

## Sources and Additional Information
* The [Page-Object gem](https://rubygems.org/gems/page-object)
* The [Webdrivers gem](https://github.com/titusfortner/webdrivers)
* The [Selenium Docker Images](https://github.com/SeleniumHQ/docker-selenium)
