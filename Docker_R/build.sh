#docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml build seurat
docker-compose -f docker-compose.yml build r

for name in shortcake_seurat shortcake_r
do
    tag=3.1.0
    docker tag rnakato/$name:$tag rnakato/$name:latest
    for tag in $tag latest
    do
        docker push rnakato/$name:$tag
    done
done
