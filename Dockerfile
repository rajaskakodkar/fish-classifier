FROM ubuntu:20.04

LABEL maintainer="rajaskakodkar16@gmail.com"

ARG NB_USER=rajas
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}
ENV PATH ${HOME}/.local/bin:$PATH

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY guitar-classifier-app.ipynb ${HOME}
COPY export.pkl ${HOME}
USER root
RUN apt-get update \
    && apt-get install -y python3 python3-pip \
    && pip3 install torch torchvision fastai jupyter voila \
    && jupyter serverextension enable voila --sys-prefix

RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

WORKDIR ${HOME}

EXPOSE 8866
CMD ["voila", "guitar-classifier-app.ipynb"]
