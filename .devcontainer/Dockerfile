FROM ocaml/opam2:ubuntu

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=opam
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG INSTALL_ZSH="true"
ARG COMMON_SCRIPT_SOURCE="https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/script-library/common-debian.sh"
ARG COMMON_SCRIPT_SHA="dev-mode"
ARG SWITCH=4.09

USER root:root
ONBUILD ENV \
    USER=root \
    HOME=/root

ENV \
    USER=root \
    HOME=/root

RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog wget ca-certificates 2>&1 \
    && wget -q -O /tmp/common-setup.sh $COMMON_SCRIPT_SOURCE \
    && if [ "$COMMON_SCRIPT_SHA" != "dev-mode" ]; then echo "$COMMON_SCRIPT_SHA /tmp/common-setup.sh" | sha256sum -c - ; fi \
    && /bin/bash /tmp/common-setup.sh "$INSTALL_ZSH" "$USERNAME" "$USER_UID" "$USER_GID" \
    && rm /tmp/common-setup.sh

RUN apt-get -y install m4 pkg-config libgmp-dev zlib1g-dev

RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

USER ${USER_UID}:${USER_GID}
ONBUILD ENV \
    USER=${USERNAME} \
    HOME=/home/${USERNAME}
ENV \
    USER=${USERNAME} \
    HOME=/home/${USERNAME}

RUN mkdir -p /home/${USERNAME}/work
WORKDIR /home/${USERNAME}/work

COPY --chown=${USERNAME}:${USERNAME} ocamlinit /home/${USERNAME}/.ocamlinit

RUN opam switch ${SWITCH}

RUN opam install core utop \
    dune merlin ocp-indent \
    async yojson core_extended core_bench cohttp async_graphics cryptokit menhir

RUN opam repo add coq-released --all-switches https://coq.inria.fr/opam/released && MAKEFLAGS="-j 4" opam install -j 4 coq
#earlybird

RUN echo 'opam init -a' | zsh
ENV PATH=$PATH:/home/opam/.opam/${SWITCH}/bin

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
