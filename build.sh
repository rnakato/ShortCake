tag=2.0.0

for name in shortcake shortcake_ver2
do
    docker tag rnakato/$name:latest rnakato/$name:$tag
    for tag in $tag latest
    do
         docker push rnakato/$name:$tag
    done
done
