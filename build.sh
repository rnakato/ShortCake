for tag in latest 1.0.2
do
    docker build -f Dockerfile -t rnakato/singlecell_jupyter:$tag .
    docker push rnakato/singlecell_jupyter:$tag
done
