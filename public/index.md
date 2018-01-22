[< Back](../)

# Public endpoints

All of these endpoints can be requested directly or through OAuth2. (In the future, authentication through OAuth2 will give you higher request limits.)

### GET /api/currencies <span class="latest">latest</span>

Lists all known currencies. (_[example](https://preview.cryptfolio.com/api/currencies)_)

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
      "id": 1,                # Unique currency ID, immutable
      "code": "btc",          # Unique currency code, mutable
      "title": "Bitcoin",
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

### GET /api/currencies/CODE <span class="latest">latest</span>

Get the information about a currency. (_[example](https://preview.cryptfolio.com/api/currencies/btc)_)

```
GET /api/currencies/btc
```

```json
{
  "success": true,
  "time": 1512697998,
  "result": {
    "id": 1,                # Unique currency ID, immutable
    "code": "btc",          # Unique currency code, mutable
    "title": "Bitcoin",
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

### GET /api/currencies/CODE/exchanges <span class="coming">coming soon</span>

List all exchanges that trade that currency.

### GET /api/currencies/cryptocurrencies <span class="latest">latest</span>

Lists all known cryptocurrencies. (_[example](https://preview.cryptfolio.com/api/currencies/cryptocurrencies)_)

### GET /api/currencies/fiat <span class="latest">latest</span>

Lists all known fiat currencies. (_[example](https://preview.cryptfolio.com/api/currencies/fiat)_)

### GET /api/currencies/tokens <span class="latest">latest</span>

Lists all known Ethereum tokens. (_[example](https://preview.cryptfolio.com/api/currencies/tokens)_)

### GET /api/exchanges <span class="coming">coming soon</span>

Lists all known exchanges.

### GET /api/exchanges/KEY <span class="coming">coming soon</span>

List information, exchange pairs, and current rates from a particular exchange.

```
GET /api/exchanges/bitstamp
```

### GET /api/exchanges/KEY/CURRENCY1/CURRENCY2 <span class="coming">coming soon</span>

Lists historical rates for a particular currency pair on an exchange.

```
GET /api/exchanges/bitstamp/btc/usd
```

### GET /api/sources <span class="coming">coming soon</span>

List all known data sources.

### GET /api/source/KEY <span class="coming">coming soon</span>

List information about a given data source key.
