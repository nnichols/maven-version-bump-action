# Maven Version Bump Action

A simple GitHub Actions to bump the version of Maven projects.

When triggered, this action will look at the commit message of HEAD~1 and determine if it contains one of `#major`, `#minor`, or `#patch` (in that order of precedence).
If true, it will use Maven to bump your pom's version.

You can override this default behavior by setting a release type, setting type will override the above commit message check.

For example, a `#minor` update to version `1.3.9` will result in the version changing to `1.4.0`.
The change will then be committed.

## Sample Usage

```yaml
name: Clojure Version Bump

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - name: Checkout Latest Commit
      uses: actions/checkout@v2

    - name: Bump Version
      id: bump
      uses: nnichols/maven-version-bump-action@v3
      with:
        github-token: ${{ secrets.github_token }}

    - name: Print Version
      run: "echo 'New Version: ${{steps.bump.outputs.version}}'"
```

## Supported Arguments

* `github-token`: The only required argument. Can either be the default token, as seen above, or a personal access token with write access to the repository
* `git-email`: The email address each commit should be associated with. Defaults to a github provided noreply address
* `git-username`: The GitHub username each commit should be associated with. Defaults to `github-actions[bot]`
* `type`: This will overide the release type this can  be minor, patch or major. if not set will use comments.
* `pom-path`: The path within your directory the pom.xml you intended to change is located.

## Outputs

* `version` - The after-bump version. Will return the old version if bump was not necessary.

## Licensing

Copyright © 2021-2022 [Nick Nichols](https://nnichols.github.io/)

Distributed under the [MIT License](https://github.com/nnichols/maven-version-bump-action/blob/master/LICENSE)
