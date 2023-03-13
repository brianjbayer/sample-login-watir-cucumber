## Running Using Other Selenium Standalone Containers
You can also run the tests using other Selenium Standalone
containers (such as Firefox and Edge) with the docker compose
framework.

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
