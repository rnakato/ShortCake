#docker-compose -f docker-compose.yml build
#docker-compose -f docker-compose.yml build light
#docker-compose -f docker-compose.yml build default
#docker-compose -f docker-compose.yml build full
#docker-compose -f docker-compose.yml build scvi
#docker-compose -f docker-compose.yml build rapidsc

#exit
reponame=shortcake_light
tag=3.4.0
#docker tag rnakato/$reponame:$tag rnakato/$reponame:latest
#apptainer build -F /work/SingularityImages/$reponame.$tag.sif docker-daemon://rnakato/$reponame:$tag


#docker save -o $reponame.tar rnakato/$reponame
#singularity build -F $reponame.sif docker-archive://$reponame.tar

for name in shortcake_light shortcake shortcake_full shortcake_scvi shortcake_rapidsc
do
    tag=3.4.0
    docker tag rnakato/$name:$tag rnakato/$name:latest
    for tag in $tag latest
    do
         docker push rnakato/$name:$tag
    done
done
