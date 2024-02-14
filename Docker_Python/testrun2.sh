

for tool in dictys
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake_ver2 run_env.sh $tool python -c "import $tool"
done

echo "STELLAR"
docker run -it --rm rnakato/shortcake_ver2 run_env.sh stellar python -c "from STELLAR import STELLAR"

for tool in gears
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake_ver2 run_env.sh gears python -c "import $tool"
done
