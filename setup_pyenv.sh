mkdir ~/.ve

pyenv install 3.6.2
pyenv install 2.7.14

pyenv virtualenv 3.6.2 jupyter3
pyenv virtualenv 2.7.14 ipython2
# pyenv virtualenv 3.6.2 tools3
# pyenv virtualenv 2.7.14 tools2


pyenv activate jupyter3
pip install jupyter
python -m ipykernel install --user
pyenv deactivate

pyenv activate ipython2
pip install ipykernel
python -m ipykernel install --user
pyenv deactivate


# pyenv activate tools3
# pip install youtube-dl gnucash-to-beancount rows
# pyenv deactivate

# pyenv activate tools2
# pip install rename s3cmd fabric mercurial
# pyenv deactivate

pyenv global 3.6.2 2.7.14 jupyter3 ipython2
# pyenv global 3.6.2 2.7.14 jupyter3 ipython2 tools3 tools2

# Uncomment this in .zshrc:
pyenv virtualenvwrapper_lazy

ipython profile create
curl -L http://hbn.link/hb-ipython-startup-script > ~/.ipython/profile_default/startup/00-venv-sitepackages.py


# After this one can:
# Create directories and virtualenvs with `mkproject proj3`
# Switch directory and virtualenv with `workon proj3`
# Create virtualenvs with `mkvirtualenv -a ~/coding/proj2 -p python2 proj2`
