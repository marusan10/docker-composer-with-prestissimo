#!/bin/bash

versions=("7.1" "7.0" "5.6")

generated_warning() {
	cat <<-EOH
		#
		# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
		#
		# PLEASE DO NOT EDIT IT DIRECTLY.
		#
	EOH
}

for version in ${versions[@]}; do

    dockerfiles=()

    { generated_warning; cat Dockerfile-debian.template; } > "$version/Dockerfile"
    sed -ri -e 's!%%TAG%%!'"$version"'!' "$version/Dockerfile"

    if [ -d "$version/alpine" ]; then
        { generated_warning; cat Dockerfile-alpine.template; } > "$version/alpine/Dockerfile"
        sed -ri -e 's!%%TAG%%!'"$version-alpine"'!' "$version/alpine/Dockerfile"
    fi
done

