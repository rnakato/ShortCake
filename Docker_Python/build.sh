#docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml build light
docker-compose -f docker-compose.yml build default
docker-compose -f docker-compose.yml build full
docker-compose -f docker-compose.yml build scvi
docker-compose -f docker-compose.yml build rapidsc

#reponame=shortcake
#docker save -o $reponame.tar rnakato/$reponame
#singularity build -F $reponame.sif docker-archive://$reponame.tar

for name in shortcake shortcake_light shortcake_full shortcake_scvi shortcake_rapidsc
do
    tag=3.1.0
    docker tag rnakato/$name:$tag rnakato/$name:latest
    for tag in $tag latest
    do
         docker push rnakato/$name:$tag
    done
done
