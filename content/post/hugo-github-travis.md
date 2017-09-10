+++
title = "Hugo to Github Pages"
date = "2017-05-10"
tags = ["go", "golang", "hugo", "development"]
draft = false
+++

This website is powered by Hugo static site generator and hosted by Github
Pages.

Repository with name `<username>.github.io` uses `master` branch as website
content. You can also provide a Jekyll-based website to master branch, but I
prefer to use  the Hugo SSG, due to its performance and features. Also, I like
to keep both source and generated code in same repository in different branches.
For example, the source code of this site is stored in `source` branch.

Here is some code that I use to build website from `source` branch and push it
to `master`.


```yaml
language: go
go: 1.9

branches:
  only:
    - source

before_install:
  - git config --global user.name "${GIT_NAME}"
  - git config --global user.email "${GIT_EMAIL}"

install:
  - go get -u -v github.com/spf13/hugo

script:
  - git clone https://github.com/fuegowolf/cocoa-eh-hugo-theme.git themes/cocoa-eh
  - hugo

after_success:
  - cd public
  - git init
  - git remote add origin https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
  - touch .nojekyll
  - git add -A
  - git commit -m "Generated Hugo Site by Travis CI [Build#${TRAVIS_BUILD_NUMBER}]"
  - git push -f "https://${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${GITHUB_REPO}.git" ${TARGET_BRANCH}

env:
  global:
    - GIT_NAME: "Travis CI"
    - GITHUB_USER: leonidboykov
    - GITHUB_REPO: leonidboykov.github.io
    - TARGET_BRANCH: master
```

`GIT_EMAIL` and `GITHUB_TOKEN` specified as private variables (the easest way is
to use the Repository Settings).
