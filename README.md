# Supported tags and respective `Dockerfile` links

- `1.3`, `1`, `latest`
- `1.3-alpine`, `1-alpine`, `alpine`

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

