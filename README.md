# ldapauth
ldapauth is a small [Rack](https://rack.github.io/) application that does basic access authentication and returns nothing.

## Examples
### nginx + Passenger
ldapath with [ngx_http_auth_request_module](https://nginx.org/en/docs/http/ngx_http_auth_request_module.html) and [Passenger](https://www.phusionpassenger.com/library/config/nginx/reference/).

```
server {
  auth_request /_ldapauth;

  location = /_ldapauth {
    passenger_enabled on;
    passenger_app_root /path/to/ldapauth;
    internal;
  }
}
```

Note that `auth_request` subrequests are also subject to `client_max_body_size`.
