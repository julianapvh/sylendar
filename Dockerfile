# Use the official Python image as the base image
FROM python:3.12.2

# Set the working directory in the container
WORKDIR /tcc_django

# Copy the application files into the working directory
COPY . /agendamentos

# Install the application dependencies
RUN pip install -r requirements.txt

# Define the entry point for the container
CMD ["python", "manage.py", "runserver", "127.0.0.1:8000"]