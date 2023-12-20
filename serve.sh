docker build --tag 'dhuckaby-mkdocs' .
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs dhuckaby-mkdocs
