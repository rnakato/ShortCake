for tool in scvi scgen
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake_ver2 run_env.sh scvi-scgen python -c "import $tool"
done

for tool in dictys
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake_$tool run_env.sh $tool python -c "import $tool"
done

for tool in gears
do
    command="python -c \"import "$tool"\""
    echo $command
    docker run -it --rm rnakato/shortcake_stellar-gears-saturn run_env.sh gears python -c "import $tool"
done
