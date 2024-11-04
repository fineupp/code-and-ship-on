FROM debian

RUN useradd -ms /bin/bash websson

#ENABLE THIS IF YOUR USER SHALL HAVE A DEFAULT PASSWORD
#RUN echo "websson:websson" | chpasswd
 
ARG MINIFORGE_NAME=Miniforge3
ARG MINIFORGE_VERSION=24.7.1-0
ARG TARGETPLATFORM

ENV CONDA_DIR=/home/websson/mamba
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=${CONDA_DIR}/bin:${PATH}

RUN apt-get update > /dev/null && \
    apt-get install --no-install-recommends --yes \
        wget bzip2 ca-certificates \
        git \
        ssh \
        sudo \
        wipe \
        git-core \
        zlib1g-dev \
        build-essential \
        libssl-dev \
        libreadline-dev \
        libyaml-dev \
        libsqlite3-dev \
        sqlite3 \
        libxml2-dev \
        libxslt1-dev \
        libcurl4-openssl-dev \
        libffi-dev \
        vim \
        curl \
# WITH AUTOSSH YOU CAN KEEP AN SSH TUNNEL ALIVE AND WITH PROXYCHAINS YOU CAN MAKE A SSH SOCKS5 PROXY INTO AN HTTP PROXY
        autossh \
        proxychains4 \
       # WIREGUARD VPN TUNNEL. NOTE FOR WIREGUARD THE CONTAINER NEEDS CAP_ADD NET_ADMIN PRIVILEGES!
       # wireguard \
        nginx \
        unzip \
        zip \
        psmisc \
        cron \
        screen \
        pkg-config \
        apt-utils \
        > /dev/null && \
    apt-get clean  

RUN mkdir /home/updates
ADD docker-scripts /home/updates/docker-scripts
RUN  ln -s /home/updates/docker-scripts /docker-scripts

RUN usermod -aG sudo websson
USER websson 
WORKDIR /home/websson

ADD launchers /home/updates/launchers
RUN  ln -s /home/updates/launchers /home/websson/launchers

ADD keys /home/websson/.keys
ADD log /home/websson/log

# SAMPLE CLIENT CONFIG FOR A WIREGUARD VPN TUNNEL. NOTE FOR WIREGUARD THE CONTAINER NEEDS CAP_ADD NET_ADMIN PRIVILEGES!
#ADD wireguard /home/websson/wireguard
ADD startup /home/websson/startup

ADD installers /home/updates/installers
RUN  ln -s /home/updates/installers /home/websson/installers

ADD nginx /home/websson/nginx

RUN git clone https://github.com/excid3/asdf.git ~/.asdf
RUN echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
RUN echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc
RUN echo 'legacy_version_file = yes' >> ~/.asdfrc
RUN echo 'export EDITOR="code --wait"' >> ~/.bashrc
RUN exec $SHELL
RUN /home/websson/.asdf/bin/asdf plugin add nodejs

RUN    wget --no-hsts --quiet https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VERSION}/${MINIFORGE_NAME}-${MINIFORGE_VERSION}-Linux-$(uname -m).sh -O /tmp/miniforge.sh && \ 
 /bin/bash /tmp/miniforge.sh -b -p ${CONDA_DIR} && \
    rm /tmp/miniforge.sh && \
    conda clean --tarballs --index-cache --packages --yes && \
    find ${CONDA_DIR} -follow -type f -name '*.a' -delete && \
    find ${CONDA_DIR} -follow -type f -name '*.pyc' -delete && \
    conda clean --force-pkgs-dirs --all --yes && \ 
    echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate base" >> ~/.bashrc

USER root
RUN    echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate base" >> /etc/skel/.bashrc

COPY  websson_trigger_reset /usr/sbin/websson_trigger_reset
COPY  websson_update_user_pass /usr/sbin/websson_update_user_pass
COPY  websson_user_reset /usr/sbin/websson_user_reset

#THIS IS GOOD IF YOU WANT TO ROUTE WIREGUARD TRAFFIC THROUGH AN SSH TUNNEL. THIS DOES THE UDP/TCP TRANSLATION
#COPY  proxyguard-client /usr/sbin/proxyguard-client
#COPY  proxyguard-server /usr/sbin/proxyguard-server

#IF YOU WANT TO MAKE YOUR APP AVAILABLE ON A PUBLIC NETWORK OR INTERNET, BUT HOST IN A PRIVATE NETWORK E.G. SELF HOST AT HOME
# CHISEL IS GREAT  TO CREATE AN TCP TUNNEL
#COPY  chisel /usr/sbin/chisel


#IF YOU WANT TO MAKE YOUR APP AVAILABLE ON A PUBLIC NETWORK OR INTERNET, BUT HOST IN A PRIVATE NETWORK E.G. SELF HOST AT HOME
RUN wget https://github.com/boringproxy/boringproxy/releases/download/v0.10.0/boringproxy-linux-x86_64
RUN chmod +x boringproxy-linux-x86_64
RUN mv boringproxy-linux-x86_64 /usr/sbin


COPY restart_supervisor /usr/sbin/restart_supervisor
COPY stop_supervisor /usr/sbin/stop_supervisor
COPY start_supervisor /usr/sbin/start_supervisor
COPY proxychains4.conf /etc/proxychains4.conf

RUN  echo "websson ALL = NOPASSWD: /usr/sbin/websson_update_user_pass,/usr/sbin/sshd -D,/usr/sbin/websson_user_reset,/etc/init.d/nginx stop,/docker-scripts/disable_variables,/usr/bin/wg-quick" >> /etc/sudoers
RUN chown websson /home/websson/log  -R && \
    chown websson /home/websson/startup -R && \ 
#    chown websson /home/websson/wireguard -R && \ 
    chown websson  /home/websson/.keys -R 

#IF YOU WANT TO RUN AN AI MODEL IN THE CONTAINER
RUN curl -fsSL https://ollama.com/install.sh | sh

RUN mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd

USER websson 
WORKDIR /home/websson

ENV PATH="${PATH}:/home/websson/.asdf/bin/"

#IF YOU WANT NODEJS IN THE CONTAINER
RUN /home/websson/.asdf/bin/asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN   /home/websson/.asdf/bin/asdf install nodejs 20.17.0
RUN   /home/websson/.asdf/bin/asdf global nodejs 20.17.0

RUN /home/websson/mamba/bin/python -m pip install xonsh
RUN /home/websson/mamba/bin/python -m pip install uv
RUN /home/websson/mamba/bin/python -m pip install supervisor

#SSHUTTLE PROVIDES A SIMPLE VPN LIKE EXPERIENCE WITHOUT ANY FUSS VIA SSH. NEEDS CAP_ADD NET_ADMIN RIGHTS FOR THE CONTAINER
#RUN /home/websson/mamba/bin/python -m pip install sshuttle

RUN /home/websson/mamba/bin/python -m venv default_py_env
RUN . /home/websson/default_py_env/bin/activate && pip install uv
COPY aliases.txt /home/updates/
COPY patch_xonsh.sh /home/updates/
RUN cat /home/updates/aliases.txt >>  /home/websson/default_py_env/bin/activate
RUN /home/updates/patch_xonsh.sh

#IF YOU WANT TO RUN A REDIS DROP IN ALTERNATIVE VALKEY WITHIN THE CONTAINER
RUN /home/websson/.asdf/bin/asdf plugin-add valkey https://github.com/fineupp/asdf-valkey.git
RUN /home/websson/.asdf/bin/asdf install valkey 8.0.0
RUN /home/websson/.asdf/bin/asdf global valkey 8.0.0


#IF YOU WANT PIXI IN ADDITION TO MAMBA/CONDA
RUN curl -fsSL https://pixi.sh/install.sh | bash

COPY sshd_config /etc/ssh/sshd_config
COPY bash.bashrc /etc/bash.bashrc
RUN echo 'alias supervisorctl="supervisorctl -c /home/websson/startup/supervisord.conf"' >> /home/websson/.bashrc

#FOR OLLAMA
#EXPOSE 11434

#FOR JUPYTERLAB
EXPOSE 3000

#FOR VSCODE
EXPOSE 3001

# FOR SSH
EXPOSE 22

#FOR THE WEB TERMINAL
EXPOSE 9000

#FOR THE WEB APP
EXPOSE 80

ENTRYPOINT /bin/bash -c "/docker-scripts/init.sh"

