
# Docs

The documentation is manually built and hosted on gh-pages currently.

https://medium.com/dbt-local-taiwan/host-dbt-documentation-site-with-github-pages-in-5-minutes-7b80e8b62feb


```
dbt docs generate
git add -f target
# This command only commits the files under target directory
git commit -m 'your commit messages' target

# This command only push files under target directory
git subtree push --prefix target origin gh-pages

# Checkout to main
git checkout main
```
