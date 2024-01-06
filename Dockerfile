FROM squidfunk/mkdocs-material

RUN pip install --no-cache-dir \
  mkdocs-redirects \
  mkdocs-glightbox \
  mkdocs-material[imaging]

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
