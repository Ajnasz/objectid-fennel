# ObjectID generator in fennel

The project is to experiment with the fennel language ([https://fennel-lang.org/](https://fennel-lang.org/))

## Run

```sh
fennel main.fnl
```

To generate 10 objectids
```sh
fennel main.fnl 10
```

## Compile to lua

```sh
fennel --compile --require-as-include main.fnl > main.lua
```

```sh
lua main.lua
```

To generate 10 objectids
```sh
lua main.lua 10
```

### Use as a library

```sh
fennel --compile --require-as-include objectid.fnl > objectid.lua
```

```lua
oid = require'objectid'
print(oid.generate())
```

## ObjectID redis

```sh
$ fennel --compile objectid-redis.fnl > objectid-redis.lua
$ redis-cli --eval objectid-redis.lua 2
1) "62c9cba68935721da3887375"
2) "62c9cba68935721da3887376"
```
