FROM continuumio/miniconda3

RUN git clone https://github.com/leoborgnino/mentoria-astro-datos /tmp/mentoria-astro-datos

RUN conda env create -f /tmp/mentoria-astro-datos/environment.yml

RUN echo "conda activate $(head -1 /tmp/environment.yml | cut -d' ' -f2)" > ~/.bashrc
ENV PATH /opt/conda/envs/$(head -1 /tmp/environment.yml | cut -d' ' -f2)/bin:$PATH

RUN /bin/bash -c "source activate $(head -1 /tmp/environment.yml | cut -d' ' -f2)"

CMD ["/opt/conda/envs/$(head -1 /tmp/environment.yml | cut -d' ' -f2)/bin/jupyter", "notebook"]

