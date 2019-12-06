# Caffe2 Detectron

FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    protobuf-compiler python-tk

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

RUN conda update -n base -c defaults conda

RUN apt-get install -y curl grep sed dpkg vim

RUN conda install pytorch -c pytorch

RUN pip install protobuf future pycocotools opencv-python>=3.2 setuptools Cython mock

RUN git clone https://github.com/facebookresearch/detectron /detectron
# RUN pip install -r /detectron/requirements.txt
WORKDIR /detectron
RUN make

WORKDIR /data

EXPOSE 8888
CMD ["/bin/bash"]
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]





