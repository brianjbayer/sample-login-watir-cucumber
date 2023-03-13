## Running the Automated Tests Natively and Environment Variables
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
Like the docker compose framework, these tests can be run natively
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
