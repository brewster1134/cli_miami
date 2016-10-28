#### Deployment Steps
* bump version in `metadata.rb`
* add entry in `CHANGELOG.md`
* run `bundle update`
* commit changes `git add -A; git commit -m "0.0.0.pre"`
* add tag `git tag -a 0.0.0.pre`
* add version to tag message `0.0.0.pre`
* push commit and tags `git push --follow-tags`
* check travis logs `https://travis-ci.org/brewster1134/cli_miami` for successful build & deploy
* check github `https://github.com/brewster1134/cli_miami/releases` for new release with downloadable gem asset
* check rubygems `https://rubygems.org/gems/cli_miami` for new version
