#docker compose -f compose.yaml build seurat
#docker compose -f compose.yaml build r
#exit
for name in shortcake_seurat shortcake_r
do
    tag=3.5.0
    docker tag rnakato/$name:$tag rnakato/$name:latest
    for tag in $tag latest
    do
        docker push rnakato/$name:$tag
    done
done
