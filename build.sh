for tag in 1.0.1 latest
do
    docker build -f Dockerfile -t rnakato/singlecell_jupyter:$tag .
    docker push rnakato/singlecell_jupyter:$tag
done
