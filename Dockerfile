FROM python:3.8-slim
# Set the working directory 
WORKDIR /python-api-deployment
# Copy requirements.txt, app.py and install any needed packages
COPY app.py /python-api-deployment/app.py
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
# Run app.py when the container launches
CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0"]
