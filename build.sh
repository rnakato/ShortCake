for tag in latest 2020.12
do
    docker build -f Dockerfile -t rnakato/singlecell_jupyter:$tag .
    docker push rnakato/singlecell_jupyter:$tag
done

#for tag in #latest
#do
#    docker build -f Dockerfile.monocle3 -t rnakato/monocle3:$tag .
#    docker push rnakato/monocle3:$tag
#done
