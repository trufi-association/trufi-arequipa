# Build server
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS backend_build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build
RUN dotnet publish -c Release -o out

# production
FROM mcr.microsoft.com/dotnet/aspnet:8.0
ENV DEBIAN_FRONTEND=noninteractive

# Install requeriments
WORKDIR /app

# Install curl
RUN apt-get update && apt-get install -y curl

COPY --from=backend_build /app/out .

EXPOSE 5000
ENTRYPOINT ["dotnet", "OTP-Updater.dll", "--urls", "http://0.0.0.0:5000"]
