#docker-compose -f docker-compose.yml build
#docker-compose -f docker-compose.yml build seurat
#docker-compose -f docker-compose.yml build r

tag=3.0.0
for name in shortcake_seurat shortcake_r
do
  docker push rnakato/$name:$tag
done
