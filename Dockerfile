FROM nnichols/maven-version-bump-action AS BASE

COPY version-bump.sh /version-bump.sh

ENTRYPOINT ["bash", "/version-bump.sh"]
