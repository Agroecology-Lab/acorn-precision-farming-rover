FROM alpine:3.12
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/v3.12/community" >> /etc/apk/repositories
RUN apk add --no-cache build-base libffi-dev openssl-dev python3-dev curl krb5-dev linux-headers zeromq-dev lapack-dev blas-dev redis
RUN apk add cmake gcc libxml2 automake g++ subversion libxml2-dev libxslt-dev gfortran jpeg-dev py3-pip
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install wheel
RUN python3 -m pip install certifi==2020.06.20
COPY server/requirements.txt /install/server/
COPY vehicle/requirements.txt /install/vehicle/
RUN python3 -m pip install -r /install/server/requirements.txt
RUN python3 -m pip install -r /install/vehicle/requirements.txt
RUN apk add tmux
COPY . /acorn/
WORKDIR /acorn/server
ENTRYPOINT ["/bin/sh","autolaunch.sh"]
