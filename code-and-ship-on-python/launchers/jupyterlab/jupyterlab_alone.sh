FILE=/home/websson/.jupyterlab_alone.done
if test -f "$FILE"; then
echo "$FILE exists."
. /home/websson/jupyterlab_alone_venv/bin/activate && jupyter lab --ip '*' --port 80 --notebook-dir=/home/websson/jupyter_notebooks --kernel websson-default  --no-browser --IdentityProvider.token=$TOKEN &
else
mkdir /home/websson/jupyter_notebooks
#sudo chown websson /home/websson/jupyter_notebooks
chown websson /home/websson/jupyter_notebooks
#/home/websson/mamba/bin/python -m venv /home/websson/jupyterlab_alone_venv
/home/websson/mamba/bin/uv  venv  /home/websson/jupyterlab_alone_venv
. /home/websson/jupyterlab_alone_venv/bin/activate && uv pip install jupyterlab
. /home/websson/jupyterlab_alone_venv/bin/activate && uv pip install ipykernel
. /home/websson/jupyterlab_alone_venv/bin/activate && ipython kernel install --user --name=websson-default
cp /home/websson/launchers/jupyterlab/websson-default_alone/kernel.json /home/websson/.local/share/jupyter/kernels/websson-default/kernel.json
cat /home/updates/aliases.txt >>  /home/websson/jupyterlab_alone_venv/bin/activate
. /home/websson/jupyterlab_alone_venv/bin/activate && jupyter lab --ip '*' --port 80 --notebook-dir=/home/websson/jupyter_notebooks --kernel websson-default --no-browser --IdentityProvider.token=$TOKEN &
touch /home/websson/.jupyterlab_alone.done
fi
