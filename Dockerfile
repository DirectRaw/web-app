FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY web.py web.py
COPY index.html index.html

EXPOSE 5000

ENTRYPOINT ["python3", "web.py"]