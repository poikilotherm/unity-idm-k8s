# Unity IDM in Docker, automated with Kubernetes

[Unity IDM](https://www.unity-idm.eu) is an open source identity management
system, targeting usecases needing a lean solution.

## Why? Alternatives?

Other open source IAM solutions like [FreeIPA](https://www.freeipa.org) or
[Gluu](https://www.gluu.org) are offering a very complete and turn-key solution.
Unity tries to avoid this, which makes it a leaner approach when trying to
integrate already existing services.

There is also [dex](https://github.com/dexidp/dex), an even leaner approach,
mostly targeted at usage for Kubernetes logins.

Some things in this project are inspired or even copied from
[CLARIN ERIC unity-idm image](https://gitlab.com/CLARIN-ERIC/docker-unity-idm).
In contrast to their approach, this project is trying to use as much upstream
things as possible, use smaller solutions and support Kubernetes usage.

## Build
## Use
