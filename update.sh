#!/bin/bash

declare -A versions=(
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

for version in ${!versions[@]}; do

    fullVersion=${versions[$version]}
    dockerfiles=()
    composerSig=$(wget -q -O - https://composer.github.io/installer.sig); \

    phpVersions=("7.1" "7.0" "5.6")

    for phpVersion in ${phpVersions[@]}; do
        if [ -d "$version/php$phpVersion" ]; then
            { generated_warning; cat Dockerfile-debian.template; } > "$version/php$phpVersion/Dockerfile"
            sed -ri \
                -e 's!%%TAG%%!'"$phpVersion"'!' \
                -e 's!%%COMPOSER_VERSION%%!'"$fullVersion"'!' \
                -e 's!%%COMPOSER_SIG%%!'"$composerSig"'!' \
                "$version/php$phpVersion/Dockerfile"
        fi

        if [ -d "$version/php$phpVersion/alpine" ]; then
            { generated_warning; cat Dockerfile-alpine.template; } > "$version/php$phpVersion/alpine/Dockerfile"
            sed -ri \
                -e 's!%%TAG%%!'"$phpVersion"'-alpine!' \
                -e 's!%%COMPOSER_VERSION%%!'"$fullVersion"'!' \
                -e 's!%%COMPOSER_SIG%%!'"$composerSig"'!' \
                "$version/php$phpVersion/alpine/Dockerfile"
        fi
    done
done

