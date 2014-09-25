#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

url='git://github.com/dariocravero/docker-library-padrino'

echo '# maintainer: Darío Javier Cravero <dario@uxtemple.com> (@dariocravero)'

commit="$(git log -1 --format='format:%H' .)"
fullVersion="$(grep -m1 'ENV PADRINO_VERSION ' Dockerfile | cut -d' ' -f3)"

versionAliases=()
while [ "${fullVersion%.*}" != "$fullVersion" ]; do
	versionAliases+=( $fullVersion )
	fullVersion="${fullVersion%.*}"
done
versionAliases+=( $fullVersion latest )

echo
for va in "${versionAliases[@]}"; do
	echo "$va: ${url}@${commit}"
done

echo
commit="$(git log -1 --format='format:%H' onbuild)"
echo "onbuild: ${url}@${commit} onbuild"
