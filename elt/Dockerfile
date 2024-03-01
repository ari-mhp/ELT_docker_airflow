FROM python:3.8-slim

# Install PostgreSQL command-line tools + cron job
RUN apt-get update && apt-get install -y postgresql-client cron

WORKDIR /app

# Menyalin elt_script.py ke container, titik (.) = workdir
COPY elt_script.py .

# CRON setiap jam menit 0, referensi search CRON job di google
RUN echo "0 */1 * * * python /app/elt_script.py" | crontab -

# Default command yang akan dieksekusi saat menjalankan container
CMD [ "python", "elt_script.py" ]