FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app
COPY . ./
RUN dotnet publish -c Release -o output

FROM library/httpd:alpine
WORKDIR /usr/local/apache2/htdocs/wasmapp
COPY --from=build-env /app/output/wwwroot .
COPY ./httpd.conf /usr/local/apache2/conf/extra/wasmapp.conf
RUN echo "Include conf/extra/wasmapp.conf" >> /usr/local/apache2/conf/httpd.conf && \
    sed -i -e 's/Listen 80/Listen 8080/g' /usr/local/apache2/conf/httpd.conf && \
    ln -sf /dev/stdout /usr/local/apache2/logs/access.log && \
    ln -sf /dev/stderr /usr/local/apache2/logs/error.log
EXPOSE 8080
