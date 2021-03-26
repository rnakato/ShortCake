docker-compose build

docker tag rnakato/singlecell_jupyter:latest rnakato/singlecell_jupyter:2021.03

for tag in latest 2021.03
do
    docker push rnakato/singlecell_jupyter:$tag
done

exit

for tag in latest #2020.12
do
    docker build -f Dockerfile -t rnakato/singlecell_jupyter:$tag .
    docker push rnakato/singlecell_jupyter:$tag
done

#for tag in #latest
#do
#    docker build -f Dockerfile.monocle3 -t rnakato/monocle3:$tag .
#    docker push rnakato/monocle3:$tag
#done
