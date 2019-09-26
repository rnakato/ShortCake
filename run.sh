#docker run -u root -it rnakato/singlecell_jupyter /bin/bash
docker run --name notebook -p 8888:8888 \
       -v $(pwd):/home/jovyan \
       rnakato/singlecell_jupyter \
       start-notebook.sh #\
#       --NotebookApp.password='sha1:ddb766b28c2b:6b0ff3cf909a320a103b9df0587f7a1908887240'
