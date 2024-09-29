FILE=/home/websson/.jupyterlab.done
if test -f "$FILE"; then
echo "$FILE exists."
. /home/websson/jupyterlab_venv/bin/activate && jupyter lab --ip '*' --port 3001 --notebook-dir=/home/websson/jupyter_notebooks --kernel websson-default  --no-browser --IdentityProvider.token=$JUPTOKEN &
else
mkdir /home/websson/jupyter_notebooks
chown websson /home/websson/jupyter_notebooks
/home/websson/mamba/bin/uv  venv  /home/websson/jupyterlab_venv
. /home/websson/jupyterlab_venv/bin/activate &&  uv pip install jupyterlab
. /home/websson/jupyterlab_venv/bin/activate && uv pip install ipykernel
. /home/websson/jupyterlab_venv/bin/activate && ipython kernel install --user --name=websson-default
cp /home/websson/launchers/jupyterlab/websson-default/kernel.json /home/websson/.local/share/jupyter/kernels/websson-default/kernel.json
cat /home/updates/aliases.txt  >> /home/websson/jupyterlab_venv/bin/activate
. /home/websson/jupyterlab_venv/bin/activate && jupyter lab --ip '*' --port 3001 --notebook-dir=/home/websson/jupyter_notebooks --kernel websson-default --no-browser --IdentityProvider.token=$JUPTOKEN &
touch /home/websson/.jupyterlab.done
fi
