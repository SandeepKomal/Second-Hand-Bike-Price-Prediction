# Use the official Python image as a base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove the default Nginx configuration file
#RUN rm /etc/nginx/sites-enabled/default

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/sites-enabled/default

# Expose port 80 for Nginx
EXPOSE 80

# Define the command to start Nginx and Gunicorn
CMD service nginx start && gunicorn --bind 0.0.0.0:8000 app:app
