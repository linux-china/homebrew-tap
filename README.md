homebrew-tap
==================

linux_china's Homebrew Tap

# how to use?

```shell
brew tap linux-china/tap
```

# Tools

### zawk

Please refer https://github.com/linux-china/zawk

```shell
brew install --no-quarantine zawk
```

or

```shell
$ sudo xattr -r -d com.apple.quarantine $(readlink -f $(brew --prefix zawk))/bin/zawk
```

### maven-toolchains-cli

Please refer https://github.com/linux-china/maven-toolchains-cli

```shell
brew install --no-quarantine maven-toolchains-cli
```

### References

* Formula Cookbook: https://docs.brew.sh/Formula-Cookbook
* https://github.com/yschimke/homebrew-tap
* A Step-by-Step Guide To Create Homebrew Taps From GitHub
  Repos: https://betterprogramming.pub/a-step-by-step-guide-to-create-homebrew-taps-from-github-repos-f33d3755ba74
