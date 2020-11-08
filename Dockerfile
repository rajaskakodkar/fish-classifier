FROM fastai/fastai:2020-11-08

LABEL maintainer="rajaskakodkar16@gmail.com"

ARG NB_USER=app
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
RUN chown -R ${NB_UID} ${HOME} && mkdir -p /usr/etc/jupyter && chown -R ${NB_UID} /usr/etc/jupyter
USER ${NB_USER}

WORKDIR ${HOME}

RUN pip install voila \
    && jupyter serverextension enable voila --sys-prefix

EXPOSE 8866
CMD ["voila", "guitar-classifier-app.ipynb"]
