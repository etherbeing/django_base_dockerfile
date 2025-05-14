# Stage 1: Build the Blazor WebAssembly app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

# Copy the .csproj and restore dependencies
COPY ./ ./
RUN dotnet restore

# Copy the rest of the source and build the app
COPY . ./
RUN dotnet publish -c Release -o /publish

# Stage 2: Serve the Blazor app with Nginx
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy the published Blazor WASM app to nginx web root
COPY --from=build /publish/wwwroot /usr/share/nginx/html

# Optional: Custom nginx.conf to disable caching etc.
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
