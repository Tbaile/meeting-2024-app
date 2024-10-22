# Meeting 2024 app

This is a testing application that has being used to show how to containerize an application in [this presentation](https://github.com/Tbaile/meeting-2024).

## Build the app

To build the app, run the following command:

```bash
podman build --tag ghcr.io/nethesis/meeting-2024-app:latest .
```

## Configure and run the app

Copy and edit the .env.example file filling up the `APP_KEY` and database values, the application needs a running mysql database.

Then run the following command:

```bash
podman run --rm \
  --name meeting-2024-app \
  --env-file .env.container \
  -p 8080:80 \
  ghcr.io/nethesis/meeting-2024-app:latest
```

