# CryptFolio API [![Build Status](https://travis-ci.org/cryptfolionz/api.svg?branch=master)](https://travis-ci.org/cryptfolionz/api)

**_Please,_ feel free to make any contributions you feel will make this documentation better.** You can submit pull requests to the [GitHub repository](https://github.com/cryptfolio1/api/), and they will be published to [the API documentation](https://cryptfolionz.github.io/api/).

* [Example Code](examples/)
* [Public API Reference](public/)
* [User API Reference](private/)

## Request format

Do not request a public endpoint more than once per five seconds or you will be automatically blocked. (Different pricing plans have different limits.)

## API Versioning

At some point in the future, we will push out a stable `v1` of this API which you can use to build long-term applications. At any time, you can use the `latest` version to access new features, however the latest API may change at any time.

| Version | Description | Example |
|---------|-------------|---------|
| latest  | The latest version of the API. The fields and availability of this API can change without notice. | `/api/currencies` |
| v1  | Stable as at TODO (not released yet) | `/api/v1/currencies` |
| v2  | Stable as at TODO (not released yet) | `/api/v2/currencies` |

## Loading

Some of these endpoints are asynchronous - for example, endpoints where a
balance or value has to be downloaded or generated. In this case, your
request will receive an error status of "loading", and you should try again later.

For example:

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

# TODO

1. Could we add some specs that automatically check all of the endpoints described?
1. We could have a travis-ci badge...
1. In theory we could include some sample applications here too
1. User accounts/APIs will have different rate limits depending on plan
1. Could we generate the .md from the specs?
1. The specs could use a specific Ruby client, rather than manually GET (which could be included in cryptfolio CI)
