FROM continuumio/miniconda3

ADD environment.yml /tmp/environment.yml

RUN git clone https://github.com/leoborgnino/mentoria-astro-datos /tmp/mentoria-astro-datos

RUN wget --directory-prefix=/tmp/mentoria-astro-datos/dataset/ "http://iate.oac.uncor.edu/~marioagustin/files/DiploDatos.csv" -O DiploDatos.csv

RUN wget --directory-prefix=/tmp/mentoria-astro-datos/dataset/ "http://iate.oac.uncor.edu/~marioagustin/files/DiploDatos_Zoo.csv" -O DiploDatos_Zoo.csv

RUN conda env create -f /tmp/environment.yml

RUN echo "conda activate $(head -1 /tmp/environment.yml | cut -d' ' -f2)" > ~/.bashrc
ENV PATH /opt/conda/envs/$(head -1 /tmp/environment.yml | cut -d' ' -f2)/bin:$PATH

RUN /bin/bash -c "source activate $(head -1 /tmp/environment.yml | cut -d' ' -f2)"

CMD ["/opt/conda/envs/astrodatos/bin/jupyter", "notebook","--notebook-dir=/tmp/mentoria-astro-datos/","--ip=0.0.0.0","--no-browser", "--allow-root"]
