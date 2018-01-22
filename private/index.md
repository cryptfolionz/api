[< Back](../)

# Private endpoints

With all of these endpoints you will need to get permission from the user to access this data. CryptFolio uses the common OAuth2 standard to implement authorisation and authentication.

1. Make sure that you have [signed up for a CryptFolio account](https://preview.cryptfolio.com/signup).
2. In [your profile](https://preview.cryptfolio.com/profile), visit [your registered applications](https://preview.cryptfolio.com/oauth/applications)
3. Create a new application, and list all of your valid redirection URIs.
4. You will be given an application key and secret. Use these to initialise your OAuth2 client.

See [some example OAuth2 authentication code](../examples/).

### Scopes

Endpoints require the following scopes:

* **GET** (read data) requires one of the `admin` or `read` scopes.
* **POST** (create new) requires one of the `admin` or `read` scopes, AND one of the `admin` or `write` scopes.
* **PATCH** (update existing) requires one of the `admin` or `read` scopes, AND one of the `admin` or `write` scopes.
* **DELETE** (delete existing) requires one of the `admin` or `read` scopes, AND one of the `admin` or `delete` scopes.

If the user has not provided your application with sufficient scope your request will fail with `403 Forbidden`.

# User information

### GET /api/user <span class="latest">latest</span>

Retrieve key information about this user.

```
GET /api/user
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "name": "Test user",
    "email": "test@openclerk.org",
    "created_at": "2017-11-06T04:54:54.000Z"
  }
}
```

# Portfolios

### GET /api/portfolios <span class="latest">latest</span>

List all of your portfolios.

```
GET /api/portfolios
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": [{
      "id": 1,
      "title": "My portfolio",
      "created_at": "2017-11-06T04:54:54.000Z",
      "updated_at": "2017-11-23T23:01:44.000Z",

      "balances_last_updated": "2017-11-23T23:01:44.000Z",
      "histories_last_updated": "2017-11-23T23:01:44.000Z",
      "converted_balances_last_updated": "2017-11-23T23:01:44.000Z",
      "converted_histories_last_updated": "2017-11-23T23:01:44.000Z",

      "currencies": 3,
      "accounts": 4,
      "addresses": 5,
      "offsets": 0
    }, {
      ...
    }]
  }
}
```

### GET /api/portfolios/ID <span class="latest">latest</span>

List the properties and accounts of a portfolio.

```
GET /api/portfolios/1
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 1,
    "title": "My portfolio",
    "created_at": "2017-11-06T04:54:54.000Z",
    "updated_at": "2017-11-23T23:01:44.000Z",

    "balances_last_updated": "2017-11-23T23:01:44.000Z",
    "histories_last_updated": "2017-11-23T23:01:44.000Z",
    "converted_balances_last_updated": "2017-11-23T23:01:44.000Z",
    "converted_histories_last_updated": "2017-11-23T23:01:44.000Z",

    "currencies": [...],
    "accounts": [...],
    "addresses": [...],
    "offsets": [...]
  }
}
```

### POST /api/portfolios <span class="latest">latest</span>

Create a new portfolio.

```
POST /api/portfolios

{"title":"My portfolio","currencies":["btc","usd"]}
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 1,
    "title": "My portfolio",
    "created_at": "2017-11-06T04:54:54.000Z",
    "updated_at": "2017-11-23T23:01:44.000Z",

    "balances_last_updated": null,
    "histories_last_updated": null,
    "converted_balances_last_updated": null,
    "converted_histories_last_updated": null,

    "currencies": [{
      "title": "Bitcoin", "code": "btc"
    }, {
      "title": "United States dollar", "code": "usd"
    }],
    "accounts": [],
    "addresses": [],
    "offsets": []
  }
}
```

### PATCH /api/portfolios/ID <span class="latest">latest</span>

Update the attributes or currencies of a portfolio.

```
PATCH /api/portfolios/1

{"title":"My updated portfolio"}
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 1,
    "title": "My updated portfolio",
    "created_at": "2017-11-06T04:54:54.000Z",
    "updated_at": "2017-11-23T23:01:44.000Z",

    "balances_last_updated": null,
    "histories_last_updated": null,
    "converted_balances_last_updated": null,
    "converted_histories_last_updated": null,

    "currencies": [{
      "title": "Bitcoin", "code": "btc"
    }, {
      "title": "United States dollar", "code": "usd"
    }],
    "accounts": [],
    "addresses": [],
    "offsets": []
  }
}
```

### DELETE /api/portfolios/ID <span class="latest">latest</span>

Delete a portfolio.

```
DELETE /api/portfolios/1
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 1,
    "title": "My portfolio",
    "created_at": "2017-11-06T04:54:54.000Z",
    "updated_at": "2017-11-23T23:01:44.000Z",

    "balances_last_updated": null,
    "histories_last_updated": null,
    "converted_balances_last_updated": null,
    "converted_histories_last_updated": null,

    "currencies": [{
      "title": "Bitcoin", "code": "btc"
    }, {
      "title": "United States dollar", "code": "usd"
    }],
    "accounts": [],
    "addresses": [],
    "offsets": []
  }
}
```

### GET /api/portfolios/ID/balances <span class="coming">coming soon</span>

Get all current balances for a portfolio (the current balances of all account and addresses, summed together).

```
GET /api/portfolios/1/balances
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "balances": [{
      "currency": "btc",
      "balance": "10.3456",
      "balance_at": "2017-11-06T04:54:54.000Z",
      "source": "cryptfolio"
    }, {
      "currency": "ltc",
      "balance": "1023.416",
      "balance_at": "2017-11-06T04:54:54.000Z",
      "source": "cryptfolio"
    }, {
      ...
    }]
  }
}
```

### GET /api/portfolios/ID/balances/_currency_ <span class="coming">coming soon</span>

### GET /api/portfolios/ID/balances/history <span class="coming">coming soon</span>

Get the historical balances for a portfolio.

### GET /api/portfolios/ID/balances/_currency_/history <span class="coming">coming soon</span>

Get the historical balances for a portfolio for a particular currency.

```
GET /api/portfolios/1/balances/btc/history
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "balances": [{
      "currency": "btc",
      "balance": "10.3456",
      "balance_at": "2017-11-06T12:00:00.000Z",
      "source": "cryptfolio"
    }, {
      "currency": "btc",
      "balance": "9.3456",
      "balance_at": "2017-11-05T12:00:00.000Z",
      "source": "cryptfolio"
    }, {
      ...
    }]
  }
}
```

### GET /api/portfolios/ID/converted <span class="coming">coming soon</span>

Get the converted balances for a portfolio.

### GET /api/portfolios/ID/converted/history <span class="coming">coming soon</span>

Get the historical converted balances for a portfolio.

# Addresses

### GET /api/portfolios/ID/addresses <span class="latest">latest</span>

List the addresses on a portfolio. This will list the public address hashes for each address.

```
GET /api/portfolios/1/addresses
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": [{
    "id": 1,
    "title": "My address",
    "address": "1JfbZRwdDHKZmuiZgYArJZhcuuzuw2HuMu",
    "currency": { "title": "Bitcoin", "code": "btc" }
  }, {
    ...
  }]
}
```

### GET /api/portfolios/ID/addresses <span class="latest">latest</span>

Get the full details of an address.

```
GET /api/portfolios/1/addresses/1
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 1,
    "title": "My address",
    "address": "1JfbZRwdDHKZmuiZgYArJZhcuuzuw2HuMu",
    "currency": { "title": "Bitcoin", "code": "btc" },
    "valid": true,

    "created_at": "2017-11-06T04:54:54.000Z",
    "updated_at": "2017-11-23T23:01:44.000Z",
    "txns_last_updated": "2017-11-23T23:01:44.000Z"
  }
}
```

### GET /api/portfolios/ID/addresses/ID/balances <span class="coming">coming soon</span>

Get the balances for a particular address.

### GET /api/portfolios/ID/addresses/ID/txns <span class="coming">coming soon</span>

Get the transactions for a particular address.

### GET /api/portfolios/ID/addresses/ID/history <span class="coming">coming soon</span>

Get the daily history for a particular address.

### POST /api/portfolios/ID/addresses <span class="latest">latest</span>

Create a new portfolio address.

```
POST /api/portfolios/1/addresses

{"title":"New address","address":"1JfbZRwdDHKZmuiZgYArJZhcuuzuw2HuMu","currency":"btc"}
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 2,
    "title": "New address",
    "address": "1JfbZRwdDHKZmuiZgYArJZhcuuzuw2HuMu",
    "currency": { "title": "Bitcoin", "code": "btc" },
    "valid": true,

    "created_at": "2017-11-06T04:54:54.000Z",
    "updated_at": "2017-11-23T23:01:44.000Z",
    "txns_last_updated": null
  }
}
```

### PATCH /api/portfolios/ID/addresses/ID <span class="latest">latest</span>

Update an existing address with a title or address.

```
PATCH /api/portfolios/1/addresses/2

{"title":"A new address title"}
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 2,
    "title": "A new address title",
    "address": "1JfbZRwdDHKZmuiZgYArJZhcuuzuw2HuMu",
    "currency": { "title": "Bitcoin", "code": "btc" },
    "valid": true,

    "created_at": "2017-11-06T04:54:54.000Z",
    "updated_at": "2017-11-23T23:01:44.000Z",
    "txns_last_updated": null
  }
}
```

### DELETE /api/portfolios/ID/addresses <span class="latest">latest</span>

Delete a portfolio address.

```
DELETE /api/portfolios/1/addresses/2
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 2,
    "title": "A new address title",
    "address": "1JfbZRwdDHKZmuiZgYArJZhcuuzuw2HuMu",
    "currency": { "title": "Bitcoin", "code": "btc" },
    "valid": true,

    "created_at": "2017-11-06T04:54:54.000Z",
    "updated_at": "2017-11-23T23:01:44.000Z",
    "txns_last_updated": null
  }
}
```

# Accounts

### GET /api/portfolios/ID/accounts <span class="coming">coming soon</span>

List the accounts on a portfolio. This list will not reveal keys or secrets.

```
GET /api/portfolios/1/accounts
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": [{
  "accounts": [{
    "id": 1,
    "title": "My account",
    "wallet": { "title": "Bittrex", "code": "bittrex" },
    "valid": true,

    "created_at": "2017-11-06T04:54:54.000Z",
    "updated_at": "2017-11-23T23:01:44.000Z",
    "last_updated": "2017-11-23T23:01:44.000Z",
    "txns_last_updated": "2017-11-23T23:01:44.000Z",
    "history_last_updated": "2017-11-23T23:01:44.000Z"
  }, {
    ...
  }]
}
```
### GET /api/portfolios/ID/accounts/ID/balances <span class="coming">coming soon</span>

### GET /api/portfolios/ID/accounts/ID/txns <span class="coming">coming soon</span>

### GET /api/portfolios/ID/accounts/ID/history <span class="coming">coming soon</span>

### POST /api/portfolios/ID/accounts <span class="coming">coming soon</span>

### DELETE /api/portfolios/ID/accounts <span class="coming">coming soon</span>

# Offsets

### GET /api/portfolios/ID/offsets <span class="coming">coming soon</span>

### GET /api/portfolios/ID/offsets/ID/balances <span class="coming">coming soon</span>

### GET /api/portfolios/ID/offsets/ID/txns <span class="coming">coming soon</span>

### GET /api/portfolios/ID/offsets/ID/history <span class="coming">coming soon</span>

### POST /api/portfolios/ID/offsets <span class="coming">coming soon</span>

### DELETE /api/portfolios/ID/offsets <span class="coming">coming soon</span>

# Example flow: Getting the history of an address

1. `POST /api/portfolios/1/addresses` to create a new address 12
2. `GET /api/portfolios/1/addresses/12/balances` to get the latest address balance
3. `GET /api/portfolios/1/addresses/12/txns` to get the latest address transactions
