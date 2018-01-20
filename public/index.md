[< Back](../)

# Public endpoints

All of these endpoints can be requested directly or through OAuth2. (In the future, authentication through OAuth2 will give you higher request limits.)

### GET [/api/currencies](https://preview.cryptfolio.com/api/currencies) <span class="latest">latest</span>

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

### GET /api/exchanges/_key_/_currency1_/_currency2_ <span class="coming">coming soon</span>

Lists historical rates for a particular currency pair on an exchange.

```
GET /api/exchanges/bitstamp/btc/usd
```
