#docker-compose -f docker-compose.celloracle.yml build #--no-cache
docker-compose -f docker-compose.yml build #--no-cache
#docker-compose -f docker-compose.ver2.yml build #--no-cache

#reponame=shortcake
#docker save -o $reponame.tar rnakato/$reponame
#singularity build -F $reponame.sif docker-archive://$reponame.tar
