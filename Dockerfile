FROM python:3.9

# Set working directory inside container
WORKDIR /app/backend

# Copy requirements first (for caching)
COPY requirements.txt /app/backend

# Install system dependencies for mysqlclient
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project
COPY . /app/backend

# Expose Django's default port
EXPOSE 8000

# Run migrations on container startup (optional, safer in entrypoint.sh instead of Dockerfile)
# CMD ["python3", "manage.py", "migrate"]

# Start Django server
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

