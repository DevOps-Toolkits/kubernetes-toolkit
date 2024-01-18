> **For local verification and testing purposes only, do not run on a production or non-production cluster.**
> **This is a took-kit image with zsh and other tools(like kubectl, go, python, psql, zsh...)**

# Docker Run

- For linux:

```bash
docker run -it \
  --rm \
  --privileged \
  --network=host \
  --name kubetools \
  -e http_proxy="http://xxx" \
  -e https_proxy="http://xxx" \
  -v ~/.kube/config:/root/.kube/config \
  -v ~/.aws:/root/.aws \
  registry.cn-hangzhou.aliyuncs.com/jihaoyun/kube-toolkit
```

> **Pls do not add bash at the end of this command! It would use zsh by default.**

- For windows:

```bash
-v C:\Users\USERNAME\.kube:/root/.kube -v C:\Users\USERNAME\.aws:/root/.aws
```

# Introduction of tools in this container
