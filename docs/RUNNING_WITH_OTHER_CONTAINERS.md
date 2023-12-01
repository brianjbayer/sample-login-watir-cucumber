## Running Using Other Selenium Standalone Containers
You can also run the tests using other Selenium Standalone
containers (such as Firefox and Edge) with the docker compose
framework.

### Prerequisites
Before being able to run this project, you must follow the requirements
in the [PREREQUISITES.md](PREREQUISITES.md)


### To Run Using the Firefox Standalone Container
1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script setting the `BROWSER` and `SELENIUM_IMAGE`
   environment variables to specify Firefox...
   ```
   BROWSER=firefox SELENIUM_IMAGE=selenium/standalone-firefox ./script/dockercomposerun
   ```

### To Run Using the Edge Standalone Container
1. Ensure Docker is running
2. From the project root directory, run the `dockercomposerun`
   script setting the `BROWSER` and `SELENIUM_IMAGE`
   environment variables to specify Edge...
   ```
   BROWSER=edge SELENIUM_IMAGE=selenium/standalone-edge ./script/dockercomposerun
   ```
