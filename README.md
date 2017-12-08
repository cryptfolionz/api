**_Please,_ feel free to make any contributions you feel will make this documentation better.** You can submit pull requests to the [GitHub repository](https://github.com/cryptfolio1/api/).

# Request format

Do not request a public endpoint more than once per five seconds or you will be automatically blocked.

# Authentication

TODO

# API Versioning

At some point in the future, we will push out a stable v1 of the API which you can use to build your applications.

The "latest" version of an API is 

| Version | Description | Example |
|---------|-------------|---------|
| latest  | The latest version of the API. The fields and availability of this API can change without notice. | `/api/currencies` |
| v1  | Stable as at TODO (not released yet) | `/api/v1/currencies` |
| v2  | Stable as at TODO (not released yet) | `/api/v2/currencies` |

# Public endpoints

## {:.latest} GET /api/currencies

Lists all known currencies.

```
GET /api/currencies
```

```js
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
      source: null
    }, {
      ...
    }]
  }
}
```

## {:.coming} GET /api/currencies/crypto

Lists all known cryptocurrencies.

## {:.coming} /api/currencies/fiat

Lists all known fiat currencies.

## {:.coming} /api/currencies/tokens

Lists all known Ethereum tokens.

# Private endpoints

TODO

# TODO

1. Could we add some specs that automatically check all of the endpoints described?
1. We could have a travis-ci badge...
1. In theory we could include some sample applications here too
1. User accounts/APIs will have different rate limits depending on plan
