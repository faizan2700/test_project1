FROM python:3.9 as build-python  

RUN apt-get -y update \
  && apt-get install -y gettext \
  # Cleanup apt cache
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app 
COPY . /app 
RUN pip install -r requirements.txt 

RUN groupadd -r saleor && useradd -r -g saleor saleor 

RUN apt-get update \
  && apt-get install -y \
  libcairo2 \
  libgdk-pixbuf2.0-0 \
  liblcms2-2 \
  libopenjp2-7 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libssl3 \
  libtiff6 \
  libwebp7 \
  libxml2 \
  libpq5 \
  shared-mime-info \
  mime-support \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* 

EXPOSE 8000
ENV PYTHONUNBUFFERED 1

LABEL org.opencontainers.image.title="test/test"                                  \
      org.opencontainers.image.description="\
      Test Project For developing and deploying django projects."                                                         \
      org.opencontainers.image.url="https://www.google.com"                                 \
      org.opencontainers.image.source="https://github.com/faizan2700/test_project"               \
      org.opencontainers.image.authors="faizan2700"           \
      org.opencontainers.image.licenses="BSD 3" 

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]