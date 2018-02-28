---
title: "Windows Package Manager"
date: 2017-09-13T22:17:48+03:00
tags: ["scoop", "windows", "terminal", "package manager"]
draft: true
---

I've always wanted something similar to [Homebrew][brew] for macOS but for
Windows. While there is already exists the [Chocolatey][choco] manager, I found
that I've prefer to use [Scoop][scoop].

### Install scoop

Make sure that you are using PowerShell 3 compatible version of PS, type:

    $PSVersionTable

Check the `PSVersion` value, it would be something like 5.1.x for Windows 10.
Windows 7 users may find PowerShell 3 on the [Microsoft website][powershell3].

Updated execution policy (don't do thay on server):

    Set-ExecutionPolicy RemoteSigned -scope CurrentUser

Then run:

    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

### Install Packages

Installing `git` is as easy as typing

    scoop install git

If you want to use SSH in your terminal, I'll would recommend you to install
`git-with-openssh` package instead of `git` and `openssh`. The `openssh` package
contains OpenSSH v5.4, while `git-with-openssh` ships with OpenSSH v7.5.

If you would like to enable Unix commands in Windows terminal, you may
also want to install `busybox` package, which contains many common Unix tools.

### Issues

I have been using Scoop for few weeks, here are the issues I've experienced:

* `openssh` package is quiet outdated, but this problem can be solved with 
`git-with-openssh` package.
* `curl` and `wget` are aliases for `Invoke-RestMethod` command, but they are
not compatible with real curl's flags. `pshazz` package overrides this aliases 
to Scoop's packages.

<!-- 7zip
busybox
cacert
curl
git-lfs
git-with-openssh
go
gradle
hugo
jq
make
nodejs
openjdk
pshazz
python
yarn -->

[brew]: https://brew.sh/
[choco]: https://chocolatey.org/
[scoop]: http://scoop.sh/
[powershell3]: https://www.microsoft.com/en-us/download/details.aspx?id=34595
