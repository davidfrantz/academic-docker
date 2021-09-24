# academic-docker

This repository builds and publishes a Docker image with the academic CLI to import bibtex references into a Hugo Acedemic website.


## Usage 

Modify ``website`` and ``import.bib`` to your needs.

```
cd website
docker run \
    --rm \
    -it \
    -v $HOME:$HOME \
    -w $PWD \
    -u $(id -u):$(id -g) \
    davidfrantz/academic \
    academic import --bibtex import.bib
```
