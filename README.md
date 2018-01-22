# CryptFolio API [![Build Status](https://travis-ci.org/cryptfolionz/api.svg?branch=master)](https://travis-ci.org/cryptfolionz/api)

**_Please,_ feel free to make any contributions you feel will make this documentation better.** You can submit pull requests to the [GitHub repository](https://github.com/cryptfolionz/api/), and they will be published to [the API documentation](https://cryptfolionz.github.io/api/).

* [Public API Reference](public/)
* [Private API Reference](private/)
* [Enterprise API Reference](enterprise/)
* [Example Code](examples/)

## Request format

Do not request an endpoint more than once per five seconds or you may be automatically blocked. (Different pricing plans have different limits.)

## API versioning

At some point in the future, we will push out a stable `v1` of this API which you can use to build long-term applications. At any time, you can use the `latest` version to access new features, however this API may change at any time.

| Version | Description | Example | Label |
|---------|-------------|---------|-------|
| latest  | The latest version of the API. The fields and availability of this API can change without notice. | `/api/currencies` | <span class="latest">latest</span> |
| v1  | Stable as at TODO (not released yet) | `/api/v1/currencies` | <span class="v1">v1</span> |
| v2  | Stable as at TODO (not released yet) | `/api/v2/currencies` | <span class="v2">v2</span> |

## Asynchronous endpoints <span class="async">async</span>

Some of these endpoints are asynchronous - for example, endpoints where a
balance or value has to be downloaded or generated. In this case, your
request will receive an error status of "loading", and you should try again later.

For example:

```
GET /api/portfolios/1/addresses/1/balances
```

```ruby
503 Service Unavailable

{
  "success": false,
  "time": 1512697998,
  "message": "Not ready"
}
```

Make sure that you implement an exponential backoff between successive requests
(e.g. 2^n seconds between requests) to prevent getting automatically blocked.

## Types

* All dates are in ISO8601 format, e.g. `"2001-02-03T04:05:06+00:00"`
* All currency values are returned as strings, rather than floats, e.g. `"50.00501"`
* Most API responses include the `source` that was used to obtain the data, if not calculated or processed directly by CryptFolio.

# TODO

1. Could we add some specs that automatically check all of the endpoints described?
1. We could have a travis-ci badge...
1. In theory we could include some sample applications here too
1. User accounts/APIs will have different rate limits depending on plan
1. Could we generate the .md from the specs?
1. The specs could use a specific Ruby client, rather than manually GET (which could be included in cryptfolio CI)
