# ![snapcraft.io](https://assets.ubuntu.com/v1/944b8760-snapcraft-logo-bird.svg?fmt=png&w=50 "Snapcraft") Snapcraft Monthly Stats

This project is a service that will notify publishers about the metrics of their snaps. A cron job that polls the store for stats about each snap, combines this with Marketo user data, generates an email and posts the email to Marketo to send to the relevant user.

All the code here is to create a valid CronJob for Kubernetes; the logic of this service is possible with [surl](https://github.com/Roadmaster/surl/).

## Regenerate credentials

This cronjob has stored the session macaroons as secrets on k8s, and if you need to renew the session, we are using the web team account.

To generate a fresh macaroon use:

```bash
snapcraft export-login --acls package_upload --expires="2022-01-01T00:00:00" webteam-session.txt
```

**The maximum amount of time for a valid session is one year**

Extract the macaroon and discharge from the generated file and update the secrets on Kubernetes.

```bash
kubectl edit secret snapcraft-monthly-stats-email --namespace production
```

## Run the project

1. You will need to create a `.env.local` file in the root of the project with the following secrets:

    ```
    WEBTEAM_ACCOUNT_EMAIL
    WEBTEAM_ROOT_MACAROON
    WEBTEAM_DISCHARGE_MACAROON
    MARKETO_REST_DOMAIN
    MARKETO_CLIENT_ID
    MARKETO_SECRET
    SENTRY_DSN (Optional)
    ```

2. Build the Docker image: `docker build . --tag snapcraft-monthly-stats`

3. Run the Docker image: `docker run -ti --env-file .env.local snapcraft-monthly-stats`
