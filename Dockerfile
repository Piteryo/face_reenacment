FROM nvcr.io/nvidia/pytorch:20.03-py3

RUN apt-get update
# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

RUN pip install dlib

RUN apt-get install ffmpeg -y

ENV FLASK_APP=server.py FLASK_DEBUG=0 FLASK_ENV=production

RUN conda install flask --yes

COPY . /app

ENTRYPOINT [ "flask" ]

CMD [ "run", "--with_threads" ]