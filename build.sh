for tag in 1.0.0 #latest
do
    docker build -f Dockerfile.anaconda -t rnakato/singlecell:$tag .
#    docker push rnakato/singlecell:$tag
#    docker build -f Dockerfile.jupyter -t rnakato/singlecell_jupyter:$tag .
#    docker push rnakato/singlecell_jupyter:$tag
done
