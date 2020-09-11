#! /usr/bin/env bash

# Generate a valid surl credentials file from secrets
jq -n \
    --arg env "production" \
    --arg discharge "$WEBTEAM_DISCHARGE_MACAROON" \
    --arg root "$WEBTEAM_ROOT_MACAROON" \
    '{store: $env, discharge: $discharge, root: $root}' > webteam-credentials.surl

# Run the Python script
python3 main.py -e $WEBTEAM_ACCOUNT_EMAIL -s production -p package_upload -a webteam-credentials --marketo-root $MARKETO_REST_DOMAIN --marketo-client-id $MARKETO_CLIENT_ID
