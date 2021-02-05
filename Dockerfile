FROM gallowaystorm/alpine-base:latest

# Environment variables for output
ENV ANSIBLE_STDOUT_CALLBACK=debug
ENV ANSIBLE_VERBOSITY=1
ENV ANSIBLE_DIFF_ALWAYS=1

ARG TERRAFORM_VERSION=0.12.26

USER root

RUN apk update --no-cache && \
        apk add --no-cache --update python3 \
        git \
        unzip \
        wget \
        build-base \
        libffi-dev \
        python3-dev \
        openssl-dev \
        openssh-client \
        py3-pip \ 
        && \
    pip3 install --upgrade pip setuptools \
    pyOpenSSL \
    awscli \
    boto3 \
    ansible

RUN ansible-playbook --version

RUN wget -q "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_$(echo $TERRAFORM_VERSION)_linux_amd64.zip" && \
    unzip "terraform_$(echo $TERRAFORM_VERSION)_linux_amd64.zip" && \
    mv terraform /usr/local/bin/terraform && \
    rm "terraform_$(echo $TERRAFORM_VERSION)_linux_amd64.zip"

RUN terraform --version

USER ${APP_USER}
RUN whoami







