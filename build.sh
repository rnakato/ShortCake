for tag in 1.2.0 #pytorch-1.5-cuda10.1-cudnn7-devel #1.1.0
do
    docker build -f Dockerfile.v$tag -t rnakato/singlecell_jupyter:$tag .
    docker push rnakato/singlecell_jupyter:$tag
done


docker build -f Dockerfile -t rnakato/singlecell_jupyter .
docker push rnakato/singlecell_jupyter

exit
for tag in latest 1.1.0
do
    docker build -f Dockerfile.v1.1.0 -t rnakato/singlecell_ubuntu:$tag . #--no-cache
    docker push rnakato/singlecell_ubuntu:$tag
done


for tag in #latest
do
    docker build -f Dockerfile.monocle3 -t rnakato/monocle3:$tag .
    docker push rnakato/monocle3:$tag
done
