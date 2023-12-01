## Prerequisites

In order to run this project...

1. You must have Docker installed and running on your host
   machine to run the project using the docker compose framework

2. To run the tests, you must set the required environment
   variable and value...
   ```
   BASE_URL='https://the-internet.herokuapp.com'
   ```

3. To run the tests, you must set the required secret
   environment variable and value...
   ```
   LOGIN_USERNAME=tomsmith
   ```

4. To run the tests, you must set the required secret
   environment variable and value...
   ```
   LOGIN_PASSWORD=SuperSecretPassword!
   ```

> These are publicly available values but demonstrate
> basic secret management

### Optional: Creating a `.env` File
You can create a file named `.env` in the project root directory
that contains the required environment variables that will
be used by default by docker compose instead of setting them on
the command line...

> :no_entry_sign: However your `.env` file will not be used when running natively

```
BASE_URL='https://the-internet.herokuapp.com'
LOGIN_USERNAME=tomsmith
LOGIN_PASSWORD=SuperSecretPassword!
```
