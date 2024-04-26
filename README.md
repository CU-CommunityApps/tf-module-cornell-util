# tf-module-cornell-util

This repository provides Terraform modules useful in the Cornell environment.

## Change Log

### v1.1.0
- Added `additional_egress_rules` and `additional_ingress_rules` to allow customization of NACL.
- Added `excluded_cidrs` to allow excluding standard rules based on the CIDRs they contain.

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
