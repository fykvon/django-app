
# The base image used is python:3.11
FROM python:3.11

# Setting PYTHONUNBUFFERED environment variable to 1
ENV PYTHONUNBUFFERED=1

# Setting the working directory to /app
WORKDIR /app

# Upgrading pip and installing poetry package manager
# Fixed typo in the command "PythonCOPY". Changed it to "COPY"
RUN python3 -m pip install --upgrade pip "poetry==1.5.1" 

# Disabling virtualenv creation, so the installed packages are available in the system
RUN poetry config virtualenvs.create false --local 

# Copying the project's dependency files to the container
COPY pyproject.toml poetry.lock ./

# Installing project dependencies using poetry
RUN poetry install

# Copying the project files to the container
COPY mysite . 

# Exposing port 8000 for the application to listen to incoming requests
EXPOSE 8000  

# Running the command to start the application using gunicorn with the specified binding
CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]
