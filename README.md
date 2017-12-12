**_Please,_ feel free to make any contributions you feel will make this documentation better.** You can submit pull requests to the [GitHub repository](https://github.com/cryptfolio1/api/), and they will be published to [the API documentation](https://cryptfolio1.github.io/api/).

## Request format

Do not request a public endpoint more than once per five seconds or you will be automatically blocked.

## API Versioning

At some point in the future, we will push out a stable v1 of the API which you can use to build your applications.

| Version | Description | Example |
|---------|-------------|---------|
| latest  | The latest version of the API. The fields and availability of this API can change without notice. | `/api/currencies` |
| v1  | Stable as at TODO (not released yet) | `/api/v1/currencies` |
| v2  | Stable as at TODO (not released yet) | `/api/v2/currencies` |

# Public endpoints

### GET /api/currencies <span class="latest">latest</span>

Lists all known currencies. ([Example](https://preview.cryptfolio.com/api/currencies))

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

```
GET /api/currencies/btc
```

```json
{
  "success": true,
  "time": 1512697998,
  "result": {
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
  }
}
```

### GET /api/currencies/_code_/exchanges <span class="coming">coming soon</span>

List all exchanges that trade that currency.

### GET /api/currencies/crypto <span class="coming">coming soon</span>

Lists all known cryptocurrencies.

### GET /api/currencies/fiat <span class="coming">coming soon</span>

Lists all known fiat currencies.

### GET /api/currencies/tokens <span class="coming">coming soon</span>

Lists all known Ethereum tokens.

### GET /api/exchanges <span class="coming">coming soon</span>

Lists all known exchanges.

### GET /api/exchanges/_key_ <span class="coming">coming soon</span>

List information, exchange pairs, and current rates from a particular exchange.

```
GET /api/exchanges/bitstamp
```

### GET /api/exchanges/_key_ <span class="coming">coming soon</span>

Lists historical rates for a particular currency pair on an exchange.

```
GET /api/exchanges/bitstamp/btc/usd
```

# Private endpoints

With all of these endpoints you will need to provide an API key. (Documentation on authentication coming.)

For many of these endpoints, you may receive an error status of "loading" -if this is the case, then CryptFolio is currently downloading or processing the balances necessary to generate that report, and you should try again later. For example:

```
GET /api/portfolios/1/balances
```

```json
{
  "success": false,
  "time": 1512697998,
  "loading": true,
  "try_again_at": "2017-11-06T04:54:54.000Z"
}
```

In this response, `try_again_at` gives a time that you can reasonably expect the result should be available, so that you don't have to continually poll the endpoint until the result is loaded.

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

    "currencies": [...],
    "accounts": [...],
    "addresses": [...],
    "offsets": [...]
  }
}
```

### GET /api/portfolios/_id_/balances <span class="coming">coming soon</span>

Get all current balances for a portfolio (the current balances of all account and addresses, summed together).

```
GET /api/portfolios/1/balances
```

```json
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

### GET /api/portfolios/_id_/balances/_currency_ <span class="coming">coming soon</span>

### GET /api/portfolios/_id_/balances/history <span class="coming">coming soon</span>

Get the historical balances for a portfolio.

### GET /api/portfolios/_id_/balances/_currency_/history <span class="coming">coming soon</span>

Get the historical balances for a portfolio for a particular currency.

```
GET /api/portfolios/1/balances/btc/history
```

```json
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

### GET /api/portfolios/_id_/converted <span class="coming">coming soon</span>

Get the converted balances for a portfolio.

### GET /api/portfolios/_id_/converted/history <span class="coming">coming soon</span>

Get the historical converted balances for a portfolio.

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
      ... as per /currency/id format
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

List the addresses on a portfolio. This will list the public address hashes for each address.

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
      "address": "18AFFdLPk7Sg1zu8HZanVYZ1dBkhheRr7Z",
      "source": "web",

      "is_invalid": true,
      "latest_error": "Invalid checksum",

      "created_at": "2017-11-06T04:54:54.000Z",
      "updated_at": "2017-11-23T23:01:44.000Z",
      "last_updated": "2017-11-23T23:01:44.000Z",
      "txns_last_updated": "2017-11-23T23:01:44.000Z",

      "balances_ready": true,
      "next_update": "2017-11-24T23:01:44.000Z",

      "balances": [{
        "currency": "btc",
        "balance": "0.0",
        "balance_at": "2017-11-06T04:54:54.000Z",
        "sent": "1.23176138",
        "received": "1.23176138",
        "tranasctions": 118,
        "source": "blockchain.info"
      }]
    }, {
      ...
    }]
  }
}
```

### GET /api/portfolios/_id_/addresses/_id_/balances <span class="coming">coming soon</span>

Get the balances for a particular address.

### GET /api/portfolios/_id_/addresses/_id_/txns <span class="coming">coming soon</span>

Get the transactions for a particular address.

### GET /api/portfolios/_id_/addresses/_id_/history <span class="coming">coming soon</span>

Get the daily history for a particular address.

### POST /api/portfolios/_id_/addresses <span class="coming">coming soon</span>

Create a new portfolio address.

### DELETE /api/portfolios/_id_/addresses <span class="coming">coming soon</span>

Delete a portfolio address.

### GET /api/portfolios/_id_/accounts <span class="coming">coming soon</span>

List the accounts on a portfolio. This list will not reveal keys or secrets.

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
### GET /api/portfolios/_id_/accounts/_id_/balances <span class="coming">coming soon</span>

### GET /api/portfolios/_id_/accounts/_id_/txns <span class="coming">coming soon</span>

### GET /api/portfolios/_id_/accounts/_id_/history <span class="coming">coming soon</span>

### POST /api/portfolios/_id_/accounts <span class="coming">coming soon</span>

### DELETE /api/portfolios/_id_/accounts <span class="coming">coming soon</span>

### GET /api/portfolios/_id_/offsets <span class="coming">coming soon</span>

### GET /api/portfolios/_id_/offsets/_id_/balances <span class="coming">coming soon</span>

### GET /api/portfolios/_id_/offsets/_id_/txns <span class="coming">coming soon</span>

### GET /api/portfolios/_id_/offsets/_id_/history <span class="coming">coming soon</span>

### POST /api/portfolios/_id_/offsets <span class="coming">coming soon</span>

### DELETE /api/portfolios/_id_/offsets <span class="coming">coming soon</span>

# Enterprise endpoints

For [our enterprise customers](https://preview.cryptfolio.com/pricing),
you are also able to access these endpoints to create, update and delete accounts for your users:

### GET /api/users <span class="coming">coming soon</span>

List all of your user accounts.

### POST /api/users/create <span class="coming">coming soon</span>

Create a new user account.

### PATCH /api/users/_id_ <span class="coming">coming soon</span>

Update the attributes of a user account.

### DELETE /api/users/_id_ <span class="coming">coming soon</span>

Delete a user account.

# Example flow: Getting the history of an address

1. `POST /api/portfolios/1/addresses` to create a new address 12
2. `GET /api/portfolios/1/addresses/12/balances` to get the latest address balance
3. `GET /api/portfolios/1/addresses/12/txns` to get the latest address transactions

# TODO

1. Could we add some specs that automatically check all of the endpoints described?
1. We could have a travis-ci badge...
1. In theory we could include some sample applications here too
1. User accounts/APIs will have different rate limits depending on plan
1. Could we generate the .md from the specs?
1. The specs could use a specific Ruby client, rather than manually GET (which could be included in cryptfolio CI)
