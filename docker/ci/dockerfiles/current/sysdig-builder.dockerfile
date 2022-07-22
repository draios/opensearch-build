FROM ubuntu:22.10

USER root

RUN apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common \
  git \
  bash \
  python3-pip \
  cmake git gradle libblas-dev libblas64-dev gfortran libopenblas-dev libopenblas64-dev zip \
  libbz2-dev ncurses-dev libffi-dev libreadline-dev libssl-dev libsqlite3-dev liblzma-dev zlib1g-dev

RUN pip3 install pipenv

RUN git clone https://github.com/asdf-vm/asdf.git /root/.asdf --branch v0.10.2 && chmod +x /root/.asdf/asdf.sh /root/.asdf/completions/asdf.bash
RUN echo ". /root/.asdf/asdf.sh" >> /root/.bashrc &&  echo ". /root/.asdf/completions/asdf.bash" >> /root/.bashrc
ENV PATH="/root/.asdf/bin:/root/.asdf/shims:$PATH"
ENV PATH="/root/.asdf:$PATH"
RUN /bin/bash -c "source /root/.bashrc && bash -c 'echo -e which asdf'" && \
  asdf plugin add java && \
  asdf plugin add python && \
  asdf install java openjdk-11.0.2 && \
  asdf global java openjdk-11.0.2 && \
  asdf install python 3.7.13 && \
  asdf global python 3.7.13 && \
  pip3 install pipenv
ENV JAVA_HOME=/root/.asdf/installs/java/openjdk-11.0.2/
RUN mkdir /app
WORKDIR /app
ENTRYPOINT ["/bin/bash"]