FROM ubuntu:jammy

# Install required system packages for our CronJob
RUN apt-get update && apt-get install --yes --no-install-recommends python3-pip git jq

ADD entrypoint.sh main.py requirements.txt ./

# Install python packages
RUN pip3 install --no-cache-dir -r requirements.txt

ENTRYPOINT ./entrypoint.sh
