# Use official Python image (slim = smaller than full)
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory inside container
WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc libpq-dev curl netcat \
    && apt-get clean

# Install Python dependencies early for caching
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the full project
COPY . .

# Collect static files (optional)
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE 8000

# Start the server
CMD ["gunicorn", "portfolio:application", "--bind", "0.0.0.0:8000"]
