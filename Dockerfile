FROM maven:3-openjdk-11-slim AS BASE

LABEL "com.github.actions.name"="Maven Version Bump Action"
LABEL "com.github.actions.description"="A simple GitHub Actions to bump the version of Maven projects"
LABEL "com.github.actions.color"="purple"
LABEL "com.github.actions.icon"="git-commit"

LABEL "repository"="https://github.com/nnichols/maven-version-bump-action"
LABEL "homepage"="https://github.com/nnichols"
LABEL "maintainer"="Nick Nichols <nichols1991@gmail.com>"

RUN apt-get update
RUN apt-get install --no-install-recommends -y gnupg2 software-properties-common git

COPY version-bump.sh /version-bump.sh

ENTRYPOINT ["bash", "/version-bump.sh"]
