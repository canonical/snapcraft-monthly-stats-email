#! /usr/bin/env bash

# Generate a valid surl credentials file from secrets
jq -n \
    --arg env "production" \
    --arg discharge "$WEBTEAM_DISCHARGE_MACAROON" \
    --arg root "$WEBTEAM_ROOT_MACAROON" \
    '{store: $env, discharge: $discharge, root: $root}' > webteam-credentials.surl

# Run the Python script
surl_month_in_snaps.py -e $WEBTEAM_ACCOUNT_EMAIL -s production -p package_upload -a webteam-credentials
