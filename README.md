This page is a list of all of the endpoints available at https://preview.cryptfolio.com.

# Request format

Do not request a public endpoint more than once per five seconds or you will be automatically blocked.

# Authentication

TODO

# Public endpoints

## GET /api/currencies

Lists all known currencies.

```
GET /api/currencies
```

```json
{
  success: true,
  time: 1512697998,
  result: {
    count: 646,
    currencies: [{
      id: 1,
      title: "Bitcoin",
      code: "btc",
      created_at: "2017-11-06T04:54:54.000Z",
      updated_at: "2017-11-23T23:01:44.000Z",
      is_cryptocurrency: true,
      is_fiat: false,
      is_ethereum_token: false,
      ethereum_contract_address: null,
      source: null,
    }, {
      ...
    }]
  }
```

## GET /api/currencies/crypto

Lists all known cryptocurrencies.

## GET /api/currencies/fiat

Lists all known fiat currencies.

## GET /api/currencies/tokens

Lists all known Ethereum tokens.

# Private endpoints

TODO

# TODO

1. Could we add some specs that automatically check all of the endpoints described?
1. We could have a travis-ci badge...
1. In theory we could include some sample applications here too
1. User accounts/APIs will have different rate limits depending on plan
