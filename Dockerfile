FROM bioconductor/bioconductor_docker:RELEASE_3_19

WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

# setup
RUN Rscript -e "BiocManager::install(ask=FALSE)"

# now build for the workshop
RUN Rscript -e "devtools::install('.', dependencies=TRUE, build_vignettes=TRUE, repos = BiocManager::repositories())"

