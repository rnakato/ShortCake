for tag in latest 1.1.0
do
    # singlecell_ubuntu に統一
    docker build -f Dockerfile.v1.1.0 -t rnakato/singlecell_jupyter:$tag .
    docker push rnakato/singlecell_jupyter:$tag

#    docker build -f Dockerfile.jupyter -t rnakato/singlecell_jupyter:$tag .
done

for tag in latest 1.1.0 #r40u18.1 latest
do
    docker build -f Dockerfile.v1.1.0 -t rnakato/singlecell_ubuntu:$tag . #--no-cache
    docker push rnakato/singlecell_ubuntu:$tag
done

for tag in #latest
do
    docker build -f Dockerfile.monocle3 -t rnakato/monocle3:$tag .
    docker push rnakato/monocle3:$tag
done

exit

tag=r35u18
#docker build -f Dockerfile.ubuntu.R35.u18 -t rnakato/singlecell_ubuntu:$tag .
#docker push rnakato/singlecell_ubuntu:$tag

for tag in #dorowu-bionic
do
    docker build -f Dockerfile.dorowu -t rnakato/singlecell_ubuntu:$tag . --no-cache
#    docker push rnakato/singlecell_ubuntu:$tag
done
