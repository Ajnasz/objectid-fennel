# ObjectID generator in fennel

The project is to experiment with the fennel language (https://fennel-lang.org/)

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
for i in *.fnl
do
	fennel --compile $i > "${i%.*}.lua"
done
```

```sh
lua main.lua
```

To generate 10 objectids
```sh
lua main.lua 10
```
