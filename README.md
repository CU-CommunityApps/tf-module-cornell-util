# tf-module-cornell-util

This repository provides Terraform modules useful in the Cornell environment.

## Change Log

### v1.0.0
- Initial release

## Auto-Release

This repository is configured with a Github workflow to automatically created releases.
```
$ git add .
$ git commit -m "blah, blah"
$ git tag -a v1.0.0 -m "v1.0.0"
$ git push origin --follow-tags

# OR, if you have set the global push.followTags settings to true
$ git push origin
```
