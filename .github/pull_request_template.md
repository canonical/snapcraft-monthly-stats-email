## Done

- 

## QA

1. Pull the branch
2. Ask for the `.env.local` file secrets
3. Docker build: `docker build . --tag test`
4. Docker run: `docker run -ti --env-file .env.local test`
