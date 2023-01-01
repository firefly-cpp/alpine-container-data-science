# A basic container image for performing data science reproducibility studies based on Alpine Linux

## About
The repository is devoted to a sample container image built on the top of Alpine Linux that installs some data science dependencies using the "apk" package manager and runs a python script.

## Build && run

### Docker

The image can be built using the following command:

```sh
$ docker build --tag ds .
```

Run the image using 

```sh
docker run -it --name ds-container -v "$PWD:/var/ds" ds
```

### Podman

The image can be built using the following command:

```sh
$ podman build --tag ds .
```

Run the image using 

```sh
podman run -it --name ds-container -v "$PWD:/var/ds" ds
```

## Why Alpine Linux for data science?

- tiny container image,
- allow a lot of customizations,
- excellent package manager,
- a lot of data science tools already exist in the Alpine ecosystem and be easily installed using the "apk" command ( e.g., Python tools: NumPy, scipy, scikit-learn, seaborn, matplotlib,
niapy, deap, pyswarms, jupyter, etc.) NOTE: if you are installing a Python package using "apk" that is not pure CLI (Command Line Interface), you should prepend "py3-" before the name of
the package,
- excellent community.
