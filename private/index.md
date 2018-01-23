[< Back](../)

# Private endpoints

<section class="warning">**NOTE** This API specification is still under heavy development. Follow <a href="https://support.cryptfolio.com/s1-general/updates">CryptFolio Updates</a> to stay in the loop.</section>

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

Retrieve key information about this user. Requires one of the `admin`, `read` or `info` scopes.

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
    "created_at": "2017-11-06T04:54:54+00:00"
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
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

    "balances_last_updated": "2017-11-23T23:01:44+00:00",
    "histories_last_updated": "2017-11-23T23:01:44+00:00",
    "converted_balances_last_updated": "2017-11-23T23:01:44+00:00",
    "converted_histories_last_updated": "2017-11-23T23:01:44+00:00",

    "currencies": 3,
    "accounts": 4,
    "addresses": 5,
    "offsets": 0
  }, {
    ...
  }]
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
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

    "balances_last_updated": "2017-11-23T23:01:44+00:00",
    "histories_last_updated": "2017-11-23T23:01:44+00:00",
    "converted_balances_last_updated": "2017-11-23T23:01:44+00:00",
    "converted_histories_last_updated": "2017-11-23T23:01:44+00:00",

    "currencies": [...],
    "accounts": [...],
    "addresses": [...],
    "offsets": [...],
    "source": "private-api"
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
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

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
    "offsets": [],
    "source": "private-api"
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
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

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
    "offsets": [],
    "source": "private-api"
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
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

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
    "offsets": [],
    "source": "private-api"
  }
}
```

### GET /api/portfolios/ID/balances <span class="latest">latest</span> <span class="async">async</span>

Get all current balances for a portfolio (the current balances of all accounts, addresses and offsets, summed together).

```
GET /api/portfolios/1/balances
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": [{
    "currency": "btc",
    "balance": "10.0",
    "balance_at": "2017-11-06T04:54:54+00:00",
    "source": "cryptfolio"
  }, {
    "currency": "usd",
    "balance": "0.0",
    "balance_at": "2017-11-06T04:54:54+00:00",
    "source": "cryptfolio"
  }]
}
```

### GET /api/portfolios/ID/balances/_currency_ <span class="coming">coming soon</span>

### GET /api/portfolios/ID/balances/history <span class="coming">coming soon</span>

Get the historical balances for a portfolio.

### GET /api/portfolios/ID/balances/_currency_/history <span class="coming">coming soon</span>

Get the historical balances for a portfolio for a particular currency.

### GET /api/portfolios/ID/converted <span class="latest">latest</span> <span class="async">async</span>

Get the converted balances for a portfolio, in each of the users' portfolio currencies, as if
all balances across all currencies were converted into that currency.

```
GET /api/portfolios/1/converted
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": [{
    "currency": "btc",
    "balance": "10.0",
    "balance_at": "2017-11-06T04:54:54+00:00",
    "source": "cryptfolio"
  }, {
    "currency": "usd",
    "balance": "117753.60",         # e.g. BTC/USD is 11,775.36
    "balance_at": "2017-11-06T04:54:54+00:00",
    "source": "cryptfolio"
  }]
}
```

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

### GET /api/portfolios/ID/addresses/ID <span class="latest">latest</span>

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

    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",
    "txns_last_updated": "2017-11-23T23:01:44+00:00",
    "source": "private-api"
  }
}
```

### GET /api/portfolios/ID/addresses/ID/balances <span class="latest">latest</span> <span class="async">async</span>

Get the balances for a particular address.

```
GET /api/portfolios/1/addresses/1/balances
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": [{
    "currency": { "title": "Bitcoin", "code": "btc" },
    "balance": "50.00501",
    "transactions": 3,           # may be null
    "sent": "0.0",               # may be null
    "received": "50.00501",      # may be null

    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

    "source": "blocktrail"
  }]
}
```

### GET /api/portfolios/ID/addresses/ID/transactions <span class="latest">latest</span> <span class="async">async</span>

Get the transactions for a particular address.

```
GET /api/portfolios/1/addresses/1/transactions
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": [{
    "currency": { "title": "Bitcoin", "code": "btc" },
    "delta": "50.0",             # positive (incoming) or negative (outgoing)
    "txn_at": "2017-11-06T04:54:54+00:00",
    "fee": "0.0",                # any fee associated with the txn, may be null
    "reference": "abc123",       # any reference associated with the txn, may be null;
                                 # for addresses, this is often the network transaction ID

    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

    "source": "blocktrail"
  }, {
    ...
  }]
}
```

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

    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",
    "txns_last_updated": null,
    "source": "private-api"
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

    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",
    "txns_last_updated": null,
    "source": "private-api"
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

    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",
    "txns_last_updated": null,
    "source": "private-api"
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

    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",
    "last_updated": "2017-11-23T23:01:44+00:00",
    "txns_last_updated": "2017-11-23T23:01:44+00:00",
    "history_last_updated": "2017-11-23T23:01:44+00:00"
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

### GET /api/portfolios/ID/offsets <span class="latest">latest</span>/span>

List the offsets on a portfolio.

```
GET /api/portfolios/1/offsets
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": [{
    "id": 1,
    "title": "My offset",
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00"
  }, {
    ...
  }]
}
```

### GET /api/portfolios/ID/offsets/ID <span class="latest">latest</span>

Get the full details of an offset, including its balances.

```
GET /api/portfolios/1/offsets/1
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 1,
    "title": "My offset",
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

    "balances": [{
      "currency": "btc",
      "balance": "10.0",
      "created_at": "2017-11-06T04:54:54+00:00",
      "updated_at": "2017-11-23T23:01:44+00:00",
      "source": "private-api"
    }, {
      "currency": "ltc",
      "balance": "1.0",
      "created_at": "2017-11-06T04:54:54+00:00",
      "updated_at": "2017-11-23T23:01:44+00:00",
      "source": "private-api"
    }]
  }
}
```

### POST /api/portfolios/ID/offsets <span class="latest">latest</span>

Create a new offset with a collection of offset balances.

```
POST /api/portfolios/1/offsets

{"title":"My second offset","balances":[
  {"currency":"btc","balance":"10"},
  {"currency":"ltc","balance":"1"}
]}
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 2,
    "title": "My second offset",
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

    "balances": [{
      "currency": "btc",
      "balance": "10.0",
      "created_at": "2017-11-06T04:54:54+00:00",
      "updated_at": "2017-11-23T23:01:44+00:00",
      "source": "private-api"
    }, {
      "currency": "ltc",
      "balance": "1.0",
      "created_at": "2017-11-06T04:54:54+00:00",
      "updated_at": "2017-11-23T23:01:44+00:00",
      "source": "private-api"
    }]
  }
}
```

### PATCH /api/portfolios/ID/offsets/ID <span class="latest">latest</span>

Update an existing offset with a new title. If `balances` is set, replaces the offset balances with a new collection of balances.

```
PATCH /api/portfolios/1/offsets/2

{"title":"My second offset","balances":[
  {"currency":"btc","balance":"5"},
  {"currency":"usd","balance":"10"}
]}
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 2,
    "title": "My second offset",
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

    "balances": [{
      "currency": "btc",
      "balance": "5.0",
      "created_at": "2017-11-06T04:54:54+00:00",
      "updated_at": "2017-11-23T23:01:44+00:00",
      "source": "private-api"
    }, {
      "currency": "usd",
      "balance": "10.0",
      "created_at": "2017-11-06T04:54:54+00:00",
      "updated_at": "2017-11-23T23:01:44+00:00",
      "source": "private-api"
    }]
  }
}
```

### DELETE /api/portfolios/ID/offsets <span class="latest">latest</span>

Delete a portfolio offset and its associated balances.

```
DELETE /api/portfolios/1/offsets/2
```

```ruby
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 2,
    "title": "My second offset",
    "created_at": "2017-11-06T04:54:54+00:00",
    "updated_at": "2017-11-23T23:01:44+00:00",

    "balances": [{
      "currency": "btc",
      "balance": "5.0",
      "created_at": "2017-11-06T04:54:54+00:00",
      "updated_at": "2017-11-23T23:01:44+00:00",
      "source": "private-api"
    }, {
      "currency": "usd",
      "balance": "10.0",
      "created_at": "2017-11-06T04:54:54+00:00",
      "updated_at": "2017-11-23T23:01:44+00:00",
      "source": "private-api"
    }]
  }
}
```

# Example flow: Getting the history of an address

1. `POST /api/portfolios/1/addresses` to create a new address with an `id` of `12`
2. `GET /api/portfolios/1/addresses/12/balances` to get the latest address balance
3. `GET /api/portfolios/1/addresses/12/transactions` to get the latest address transactions
