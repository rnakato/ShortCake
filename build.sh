for tag in 1.0.3 #latest
do
    docker build -f Dockerfile.jupyter -t rnakato/singlecell_jupyter:$tag .
#    docker push rnakato/singlecell_jupyter:$tag
done

for tag in #latest 18.04
do
    docker build -f Dockerfile.ubuntu -t rnakato/singlecell_ubuntu:$tag .
    docker push rnakato/singlecell_ubuntu:$tag
done


for tag in #dorowu-bionic
do
    docker build -f Dockerfile.dorowu -t rnakato/singlecell_ubuntu:$tag . --no-cache
#    docker push rnakato/singlecell_ubuntu:$tag
done


for tag in #latest
do
    docker build -f Dockerfile.monocle3 -t rnakato/monocle3:$tag .
    docker push rnakato/monocle3:$tag
done
