homebrew-tap
==================

linux_china's Homebrew Tap

# how to use?

```shell
brew tap linux-china/tap
```

# Tools

### task-keeper

Please refer https://github.com/linux-china/task-keeper

```shell
$ brew install --no-quarantine task-keeper
$ sudo xattr -r -d com.apple.quarantine $(readlink -f $(brew --prefix task-keeper))
```

### dotenvx-rs

Please refer https://github.com/linux-china/dotenvx-rs

```shell
$ brew install --no-quarantine dotenvx-rs
$ sudo xattr -r -d com.apple.quarantine $(readlink -f $(brew --prefix dotenvx-rs))
```

### duckman

Please refer https://github.com/linux-china/duckman

```shell
$ brew install --no-quarantine duckman
$ sudo xattr -r -d com.apple.quarantine $(readlink -f $(brew --prefix duckman))
```


### maven-toolchains-cli

Please refer https://github.com/linux-china/maven-toolchains-cli

```shell
$ brew install --no-quarantine maven-toolchains-cli
```

### zawk

Please refer https://github.com/linux-china/zawk

```shell
$ brew install --no-quarantine zawk
$ sudo xattr -r -d com.apple.quarantine $(readlink -f $(brew --prefix zawk))
```


### References

* Formula Cookbook: https://docs.brew.sh/Formula-Cookbook
* https://github.com/yschimke/homebrew-tap
* A Step-by-Step Guide To Create Homebrew Taps From GitHub
  Repos: https://betterprogramming.pub/a-step-by-step-guide-to-create-homebrew-taps-from-github-repos-f33d3755ba74
