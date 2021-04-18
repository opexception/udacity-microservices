## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.udacity-microservices

install:
	# This should be run from inside a virtualenv
	. ~/.udacity-microservices/bin/activate; \
	pip install --no-cache-dir --upgrade pip && \
		pip install --no-cache-dir -r requirements.txt
	
	wget -O /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64
	chmod +x /usr/local/bin/hadolint

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	. ~/.udacity-microservices/bin/activate; \
	pylint --disable=R,C,W1203,W1202,W1309 app.py

all: install lint test
