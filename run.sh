#docker run -u root -it rnakato/singlecell_jupyter /bin/bash
docker run  \
       -e GRANT_SUDO=yes \
       -e NB_UID=$UID \
       -e NB_GID=$GID \
       -e TZ=Asia/Tokyo \
       -p 8888:8888 \
       --name notebook \
       -v $(pwd):/home/jovyan/work \
       rnakato/singlecell_jupyter \
       start-notebook.sh #\
#       --NotebookApp.password='sha1:YOUR_PASSWORD_HASH_VALUE'
