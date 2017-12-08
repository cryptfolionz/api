**_Please,_ feel free to make any contributions you feel will make this documentation better.** You can submit pull requests to the [GitHub repository](https://github.com/cryptfolio1/api/).

## Request format

Do not request a public endpoint more than once per five seconds or you will be automatically blocked.

## API Versioning

At some point in the future, we will push out a stable v1 of the API which you can use to build your applications.

The "latest" version of an API is

| Version | Description | Example |
|---------|-------------|---------|
| <span class="latest">latest</span>  | The latest version of the API. The fields and availability of this API can change without notice. | `/api/currencies` |
| <span class="v1">v1</span>  | Stable as at TODO (not released yet) | `/api/v1/currencies` |
| <span class="v2">v2</span>  | Stable as at TODO (not released yet) | `/api/v2/currencies` |

# Public endpoints

### GET /api/currencies <span class="latest">latest</span>

Lists all known currencies.

```
GET /api/currencies
```

```json
{
  "success": true,
  "time": 1512697998,
  "result": {
    "count": 646,
    "currencies": [{
      "id": 1,
      "title": "Bitcoin",
      "code": "btc",
      "created_at": "2017-11-06T04:54:54.000Z",
      "updated_at": "2017-11-23T23:01:44.000Z",
      "is_cryptocurrency": true,
      "is_fiat": false,
      "is_ethereum_token": false,
      "ethereum_contract_address": null,
      "source": null
    }, {
      ...
    }]
  }
}
```

### GET /api/currencies/_code_ <span class="coming">coming soon</span>

Get the information about a currency.

### GET /api/currencies/crypto <span class="coming">coming soon</span>

Lists all known cryptocurrencies.

### GET /api/currencies/fiat <span class="coming">coming soon</span>

Lists all known fiat currencies.

### GET /api/currencies/tokens <span class="coming">coming soon</span>

Lists all known Ethereum tokens.

# Private endpoints

With all of these endpoints you will need to provide an API key. (Documentation on authentication coming.)

### GET /api/portfolios <span class="coming">coming soon</span>

List all of your portfolios.

### POST /api/portfolios/create <span class="coming">coming soon</span>

Create a new portfolio.

### PATCH /api/portfolios/_id_ <span class="coming">coming soon</span>

Update the attributes of a portfolio.

### DELETE /api/portfolios/_id_ <span class="coming">coming soon</span>

Delete a portfolio.

### GET /api/portfolios/_id_ <span class="coming">coming soon</span>

List the properties and accounts of a portfolio.

```
GET /api/portfolios/1
```

```json
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

    "currencies": 6,
    "accounts": 12,
    "addresses": 14,
    "offsets": 15
  }
}
```

### GET /api/portfolios/_id_/currencies <span class="coming">coming soon</span>

List the currencies on a portfolio.

```
GET /api/portfolios/1/currencies
```

```json
{
  "success": true,
  "time": 1512697998,
  "result": {
    "currencies": [{
      "id": 1,
      "title": "Bitcoin",
      "code": "btc",
      // ... as per /currency/id format
    }, {
      ...
    }]
  }
}
```

### POST /api/portfolio/currencies <span class="coming">coming soon</span>

Create a new portfolio currency.

### DELETE /api/portfolio/currencies <span class="coming">coming soon</span>

Delete a portfolio currency.

### GET /api/portfolios/_id_/addresses <span class="coming">coming soon</span>

List the addresses on a portfolio.

```
GET /api/portfolios/1/addresses
```

```json
{
  "success": true,
  "time": 1512697998,
  "result": {
    "addresses": [{
      "id": 1,
      "title": "My address",
      "currency": "btc",
      "address": "1abcdef...",
      "source": "web",

      "is_invalid": true,
      "latest_error": "Invalid checksum",

      "created_at": "2017-11-06T04:54:54.000Z",
      "updated_at": "2017-11-23T23:01:44.000Z",
      "last_updated": "2017-11-23T23:01:44.000Z",
      "txns_last_updated": "2017-11-23T23:01:44.000Z"
    }, {
      ...
    }]
  }
}
```

### POST /api/portfolio/addresses <span class="coming">coming soon</span>

Create a new portfolio address.

### DELETE /api/portfolio/addresses <span class="coming">coming soon</span>

Delete a portfolio address.

### GET /api/portfolios/_id_/accounts <span class="coming">coming soon</span>

List the accounts on a portfolio.


```
GET /api/portfolios/1/accounts
```

```json
{
  "success": true,
  "time": 1512697998,
  "result": {
    "accounts": [{
      "id": 1,
      "title": "My account",
      "type": "bittrex",
      "source": "web",

      "is_invalid": false,
      "latest_error": nil,

      "created_at": "2017-11-06T04:54:54.000Z",
      "updated_at": "2017-11-23T23:01:44.000Z",
      "last_updated": "2017-11-23T23:01:44.000Z",
      "txns_last_updated": "2017-11-23T23:01:44.000Z",
      "history_last_updated": "2017-11-23T23:01:44.000Z"
    }, {
      ...
    }]
  }
}
```

### POST /api/portfolio/accounts <span class="coming">coming soon</span>

Create a new portfolio account.

### DELETE /api/portfolio/accounts <span class="coming">coming soon</span>

Delete a portfolio account.

### GET /api/portfolios/_id_/offsets <span class="coming">coming soon</span>

List the offsets on a portfolio.

### POST /api/portfolio/offsets <span class="coming">coming soon</span>

Create a new portfolio offset.

### DELETE /api/portfolio/offsets <span class="coming">coming soon</span>

Delete a portfolio offset.

# TODO

1. Could we add some specs that automatically check all of the endpoints described?
1. We could have a travis-ci badge...
1. In theory we could include some sample applications here too
1. User accounts/APIs will have different rate limits depending on plan
1. Could we generate the .md from the specs?
1. The specs could use a specific Ruby client, rather than manually GET (which could be included in cryptfolio CI)
