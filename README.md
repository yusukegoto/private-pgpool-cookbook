Overview
========

## How to Use

Chef cook book for pgpool which is constructed from postgres 9.5 and pgpool-II.

pgpool and postgres work in one-to-one.

### default

- `postgres` is on port `4321`
- `pgpool` is on port `5432`

Both postgres and pgpool are accepted with `0.0.0.0/0`.
So we can check both with and without pgpool case.

try

`Gemfile` is only used for install `chef-dk`.
I wanted `chef` command for creating both repo and cookbook templates.

```
$ vagrant up
```
