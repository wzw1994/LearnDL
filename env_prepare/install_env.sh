#!/bin/bash
# base on centos7
# if in ubuntu system can use "sudo apt install build-essential" to install 
# some basic common libs like gcc

yum remove python36 -y

# using pyenv install python3.11.5
yum install gcc zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel git libffi-devel -y
yum install epel-release -y
yum install openssl11 openssl11-devel -y

# install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash && echo -e '\nexport PYENV_ROOT="$HOME/.pyenv"\ncommand -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"\neval "$(pyenv init -)"' >> ~/.bashrc
# Make the python file debuggable
echo -e '\nexport PYDEVD_DISABLE_FILE_VALIDATION=1' >> ~/.bashrc
source ~/.bashrc

# install python3.11.5 using pyenv
export CFLAGS=$(pkg-config --cflags openssl11)
export LDFLAGS=$(pkg-config --libs openssl11)
if pyenv versions | grep -q '3.11.5'; then
    echo "Python 3.11.5 is already installed."
else
    pyenv install 3.11.5
fi
pyenv global 3.11.5

python3 -m pip install --upgrade pip

# install some dependency libs which aigc might using, will install cuda12.1 + cuDNN8.9.2
python3 -m pip install -U xformers==0.0.23.post1 
python3 -m pip install -U torchvision==0.16.2
python3 -m pip install diffusers==0.25.0 
python3 -m pip install accelerate==0.18.0
python3 -m pip install transformers==4.28.1 
python3 -m pip install opencv-python==4.7.0.72
python3 -m pip install basicsr==1.4.2
python3 -m pip install einops==0.7.0

# install some dependency libs for studing DeepLearning
python3 -m pip install d2l # Full name is "Dive into Deep Learning" which is also a book's name to teach how to using DL