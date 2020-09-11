FROM ubuntu:focal

# Install required system packages for our CronJob
RUN apt-get update && apt-get install --yes --no-install-recommends python3-pip git jq

# Install surl python package
RUN pip3 install tenacity
RUN pip3 install git+https://github.com/Roadmaster/surl.git

ADD entrypoint.sh .
ADD main.py .

ENTRYPOINT ./entrypoint.sh
