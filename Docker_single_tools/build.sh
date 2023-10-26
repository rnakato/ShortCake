tag=202310
for label in stellar-gears-saturn #scvi-scgen #dictys
do
    imagename=shortcake_$label
    docker build -f Dockerfile.$label -t rnakato/$imagename .
    docker push rnakato/$imagename
    docker tag shortcake_$label:$tag shortcake_$label
    docker push rnakato/$imagename:$tag
done
