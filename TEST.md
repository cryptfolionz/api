# Running CryptFolio API tests

With your [CryptFolio account](https://cryptfolio.com),
create a new [registered OAuth2 application](http://localhost:3000/oauth/applications) with public/info/read/write/delete permissions.

Create another test account on [CryptFolio](https://cryptfolio.com),
and [lodge a support request to enable remote login](mailto:support@cryptfolio.com). This allows the API client to login with user/password, rather than the full OAuth2 process.

Create a local `.env` file with your OAuth2 key and secret, and your test users' credentials:

```env
HOST: "https://cryptfolio.com"

OAUTH2_KEY: "36ca4f9fc7cbb8fcf71053e3..."
OAUTH2_SECRET: "2db1743cb77d2b8ae6741ddf..."
OAUTH2_REDIRECT_URI: "http://localhost:3000/api"

TEST_USER_EMAIL: "example@example.com"
TEST_USER_PASSWORD: "example"
TEST_USER_NAME: "example user"
```

You can then run the specs locally with `rspec`.
