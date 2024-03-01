FROM python:3.8-slim

# Install PostgreSQL command-line tools + cron job
RUN apt-get update && apt-get install -y postgresql-client cron

# Copy the ELT script
COPY start.sh /app/start.sh
COPY elt_script.py .

WORKDIR /app

# CRON setiap jam 3 a.m
RUN echo "0 3 * * * python /app/elt_script.py" | crontab -

# Set the default command to run the ELT script
CMD ["python", "elt_script.py"]