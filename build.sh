#docker-compose build
docker-compose -f docker-compose.R.yml build --no-cache
docker-compose -f docker-compose.yml build --no-cache

docker tag rnakato/singlecell_jupyter:latest rnakato/singlecell_jupyter:2022.03

for tag in #2022.02 latest
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
