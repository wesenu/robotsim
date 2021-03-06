# Use an official Python runtime as a parent image
FROM tensorflow/tensorflow:latest-gpu

#ENV http_proxy http://proxy.wdf.sap.corp:8080
#ENV https_proxy https://proxy.wdf.sap.corp:8080
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y libav-tools \
    python-numpy \
    python-scipy \
    python-pyglet \
    python-setuptools \
    libpq-dev \
    ca-certificates \
    libgdbm3 \
    libsqlite3-0 \
    libssl1.0.0 \
    libjpeg-dev \
    curl \
    cmake \
    swig \
    python-opengl \
    libboost-all-dev \
    libsdl2-dev \
    libcupti-dev \
    wget \
    unzip \
    git \
    vim \
    gcc \
    python-tk \
    xpra \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && easy_install pip


RUN git clone https://github.com/openai/gym.git /gym

WORKDIR /gym

RUN pip install -e .[all]

RUN git clone https://github.com/TheOssi/robotsim

WORKDIR /gym/robotsim

CMD ["python", "setup.py"]

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Run app.py when the container launches
CMD ["python", "/gym/robotsim/dqn.py"]
