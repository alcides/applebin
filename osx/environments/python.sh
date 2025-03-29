brew install python
echo "PATH:$PATH:/usr/local/opt/python@3.9/libexec/bin" >> ~/.zsh_local
export CURR=$(dirname $SCRIPT_PATH)
pip install -r $APPLEBIN/osx/environments/python_stats.pip