# pull the latest Alpine Linux instance
FROM alpine:3.17

ENV NAME=data-science-basic VERSION=0 ARCH=x86_64

LABEL org.label-schema="$NAME" \
     name="$FGC/$NAME" \
     version="$VERSION" \
     architecture="$ARCH" \
     run="podman run -it IMAGE" \
     maintainer="Iztok Fister, Jr. <iztok@iztok-jr-fister.eu>" \
     url="https://github.com/firefly-cpp/alpine-container-data-science" \
     summary="A basic container image for performing data science reproducibility studies based on Alpine Linux." \
     description="A basic container image for performing data science reproducibility studies based on Alpine Linux."

# set a workdir where we will also collect the results of python scripts
WORKDIR /var/ds/

# INSTALL THE FOLLOWING PYTHON PACKAGES
#   * niapy: Python microframework for building nature-inspired algorithms | https://github.com/NiaOrg/NiaPy
#   * niaarm: A minimalistic framework for Numerical Association Rule Mining  | https://github.com/firefly-cpp/NiaARM
#   * sport-activities-features: A minimalistic toolbox for extracting features from sports activity files written in Python | https://github.com/firefly-cpp/sport-activities-features
ENV PACKAGES="\
    py3-niapy \
    py3-niaarm \
    py3-pymoo \
    py3-sport-activities-features \
"

# INSTALL THE FOLLOWING PYTHON PACKAGES FROM PYPI
# we install packages that are not (yet) included in the Alpine Linux aports repository
ENV PYPI_PACKAGES="\
    fireflyalgorithm \
"
# upgrade base packages & install packages
# firstly, we add a testing repository (some packages that were not moved to the community yet, live there)
# NOTE: the base image (alpine:3.17, etc) is only updated when minor releases happen (3.17.1, etc), so it's likely
# there might be a change to libssl or busybox that wouldn't be pulled when installing packages; thus, we apply 'apk upgrade' step.
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk update \
    && apk upgrade && apk add --no-cache \
    python3 \
    python3-dev \
    py3-pip \
    $PACKAGES \
    && rm -rf /var/cache/apk/* \
    && pip3 install --no-cache-dir $PYPI_PACKAGES  # install packages from PYPI

# copy our Python script to run the optimization using the niapy library
COPY compare-algorithms.py .
# start optimization
RUN python3 compare-algorithms.py
# open the shell to explore the results in the export folder
CMD ["/bin/sh"]
