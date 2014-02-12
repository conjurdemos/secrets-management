Secrets Management
==================

A live demonstration of http://developer.conjur.net/patterns/secrets-management.html

Usage
-----

Generate the permissions model. The output is redirected to config.yml, which used by the web service and by the 
cucumber client testing code.

```bash
conjur script:execute -c conjur.json permissions-model.rb
```

Run the tests

```bash
cucumber
```
