tag=3.5.0
#docker compose -f compose.yaml build light
#docker compose -f compose.yaml build default
#docker compose -f compose.yaml build full
#docker compose -f compose.yaml build scvi
#docker compose -f compose.yaml build rapidsc

#reponame=shortcake_light
#apptainer build -F /work3/SingularityImages/$reponame.$tag.sif docker-daemon://rnakato/$reponame:$tag

#exit
for name in shortcake_light shortcake shortcake_full shortcake_scvi shortcake_rapidsc
do
    tag=3.5.0
    docker tag rnakato/$name:$tag rnakato/$name:latest
    for tag in $tag latest
    do
         docker push rnakato/$name:$tag
    done
done
