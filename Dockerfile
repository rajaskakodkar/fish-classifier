FROM fastdotai/fastai:2.0.2

RUN pip install voila \
    && jupyter serverextension enable voila --sys-prefix

COPY export.pkl /workspace/export.pkl
COPY guitar-classifier-app.ipynb /workspace/app.ipynb
CMD voila app.ipynb
