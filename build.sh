tag=2022.11
docker tag rnakato/shortcake:latest rnakato/shortcake:$tag

for tag in $tag latest
do
    docker push rnakato/singlecell_jupyter:$tag
done
