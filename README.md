# Supported tags and respective `Dockerfile` links

- `7.1`, `7`, `latest`
- `7.1-alpine`, `7-alpine`
- `7.0`
- `7.0-alpine`
- `5.6`, `5`
- `5.6-alpine`, `5-alpine`

# How to use this image.

## Installation / Usage

1. Install the `marusan10/composer-with-prestissimo` container:

    ``` sh
    $ docker pull marusan10/composer-with-prestissimo
    ```

2. Create a composer.json defining your dependencies.

    ``` json
    {
        "require": {
            "monolog/monolog": ">=1.0.0"
        }
    }
    ```

3. Run Composer through the Composer container:

    ``` sh
    $ docker run --rm -v $(pwd):/app marusan10/composer-with-prestissimo install
    ```

