#!/bin/bash

declare -A composerVersions=(
    [1.3]="1.3.1"
)

generated_warning() {
	cat <<-EOH
		#
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
		#
	EOH
}

for composerVersion in ${!composerVersions[@]}; do

    composerFullVersion=${composerVersions[$composerVersion]}
    composerSig=$(wget -q -O - https://composer.github.io/installer.sig); \

    phpVersions=("7.1" "7.0" "5.6")

    for phpVersion in ${phpVersions[@]}; do
        if [ -d "$composerVersion/php$phpVersion" ]; then
            { generated_warning; cat Dockerfile-debian.template; } > "$composerVersion/php$phpVersion/Dockerfile"
            sed -ri \
                -e 's!%%DOCKER_PHP_TAG%%!'"$phpVersion"'!' \
                -e 's!%%COMPOSER_VERSION%%!'"$composerFullVersion"'!' \
                -e 's!%%COMPOSER_SIG%%!'"$composerSig"'!' \
                "$composerVersion/php$phpVersion/Dockerfile"
        fi

        if [ -d "$composerVersion/php$phpVersion/alpine" ]; then
            { generated_warning; cat Dockerfile-alpine.template; } > "$composerVersion/php$phpVersion/alpine/Dockerfile"
            sed -ri \
                -e 's!%%DOCKER_PHP_TAG%%!'"$phpVersion"'-alpine!' \
                -e 's!%%COMPOSER_VERSION%%!'"$composerFullVersion"'!' \
                -e 's!%%COMPOSER_SIG%%!'"$composerSig"'!' \
                "$composerVersion/php$phpVersion/alpine/Dockerfile"
        fi
    done
done

