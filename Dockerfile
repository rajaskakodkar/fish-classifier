FROM fastdotai/fastai:2.0.2

ARG NB_USER=rajas
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
RUN chown -R ${NB_UID} /opt/conda/etc/jupyter
USER ${NB_USER}

RUN pip install voila \
    && jupyter serverextension enable voila --sys-prefix

#COPY export.pkl /workspace/export.pkl
#COPY guitar-classifier-app.ipynb /workspace/app.ipynb

EXPOSE 8866
ENTRYPOINT ["voila", "/home/${NB_USER}/guitar-classifier-app.ipynb"]
