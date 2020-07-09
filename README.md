# dockerize-blazorwasm-httpd
## Build
```
docker build -t wasmapp .
```

## Run
```
docker run -dit --name mywasmapp -p 8080:8080 wasmapp
```
