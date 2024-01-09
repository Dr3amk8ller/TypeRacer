# Use an official Ubuntu 20.04 as a base image
FROM ubuntu:20.04

# Set non-interactive mode during build
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary dependencies
RUN apt-get update && \
    apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback python3 && \
    apt-get clean

# Set non-interactive mode back to default
ENV DEBIAN_FRONTEND=dialog

# Set environment variables for Flutter
ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# Download Flutter SDK from the Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set Flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor

# Enable flutter web (switch to the stable channel, upgrade, and enable web)
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Create app directory
RUN mkdir /app/
# Copy all files into the container's app directory
COPY . /app/
# Set the working directory to the app directory
WORKDIR /app/

# Fetch dependencies and build the Flutter web project
RUN flutter pub get
RUN flutter build web

# Expose port 9000
EXPOSE 9000

# Make server startup script executable and start the web server
RUN ["chmod", "+x", "/app/flutterserver/server.sh"]
ENTRYPOINT ["/app/server/server.sh"]

