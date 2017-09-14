+++
title = "Deploy Hugo site to Github Pages with Travis CI"
date = "2017-05-10T22:17:48+03:00"
tags = ["go", "hugo", "static site"]
draft = false
+++
**Update [2017-09-10]:** This website is deploys by [Netlify](https://www.netlify.com). This
post contains old pipeline for deploying my static site.

~~This website is powered by Hugo static site generator and hosted by Github
Pages.~~

Repository with the name `<username>.github.io` uses `master` branch as website
content. You can also provide a Jekyll-based website to master branch, but I
prefer to use  the [Hugo](https://gohugo.io), due to its performance and
features. Also, I like to keep both source and generated code in same repository
in different branches. For example, the source code of this site is stored in
`source` branch.

Here is the source of `.travis-ci.yml` file that I used to build website from
`source` branch and push it to `master`.

```yaml
language: go
go: 1.9

branches:
  only:
    # Edit this line if your upstream branch is not `source`.
    - source

before_install:
  # You can't push any changes without providing user.name and user.email to git.
  - git config user.name "${GIT_NAME}"
  - git config user.email "${GIT_EMAIL}"

install:
  # Get Hugo from master branch, or download latest hugo.deb package from the
  # Releases tab.
  - go get github.com/gohugoio/hugo

before_script:
  # Clone old site files and remove them entirely. This step would save the
  # history, so you wouldn't get any history-related issues if you would like
  # to host your master branch via Caddy http.git plugin or something simular.
  - git clone --depth 1 https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git --branch ${TARGET_BRANCH} --single-branch public
  - cd public && git rm -rf . && cd ..

script:
  # You have to clone a theme if you cloned it to themes folder before.
  # - git clone <theme_repo> themes/<theme_name>
  # Otherwise you may want to add submodule with command:
  #     git submodule add <theme_repo> themes/<theme_name>
  # and skip clone step entirely.
  - hugo

after_success:
  - cd public
  - git add --all
  - git commit -m "Generated Hugo Site by Travis CI [Build#${TRAVIS_BUILD_NUMBER}]"
  # Don't forget to use --quiet flag, you don't want to expose your credentials
  # to Travis' console.
  - git push --quiet "https://${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${GITHUB_REPO}.git" ${TARGET_BRANCH}

env:
  global:
    - GIT_NAME: "Travis CI"
    - GITHUB_USER: <user_name>
    - GITHUB_REPO: <github_repo>
    - TARGET_BRANCH: master
```

`GIT_EMAIL` and `GITHUB_TOKEN` specified as private variables .The easest way is
to use the Repository Settings.
