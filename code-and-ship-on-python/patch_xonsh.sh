cd  /home/websson/mamba && git clone https://github.com/xonsh/xonsh
cd /home/websson/mamba/xonsh/xonsh && sed -i 's/-ic/-c/g' foreign_shells.py
cd /home/websson/mamba/xonsh && /home/websson/mamba/bin/pip install -e .
