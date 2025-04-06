# Use a lightweight web server
FROM nginx:alpine

# Set working directory in container
WORKDIR /usr/share/nginx/html

# Delete default nginx static files
RUN rm -rf ./*

# Copy the Flutter build web output
COPY build/web/ .

# Optional: Custom nginx config
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
