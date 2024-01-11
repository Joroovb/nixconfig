# Dotfiles

Nix flake to configure my systems

## Linux

### First run

```shell
$ home-manager --flake .#$USER@$HOSTNAME switch --extra-experimental-features nix-command --extra-experimental-features flakes
```

### After that

```shell
# Generic Linux
$ home-manager --flake .#$USER@$HOSTNAME switch
```

## Macos

### First run

```shell
$ nix run nix-darwin -- switch --flake .
```

```shell
$ darwin-rebuild switch --flake .
```

- [Setup nix, nix-darwin and home-manager from scratch on an M1 Macbook Pro ](https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050)
