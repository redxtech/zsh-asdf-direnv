# asdf-direnv
> asdf-direnv is a zsh plugin that loads asdf & asdf-direnv.

## Installing

### zinit
Add this to your zinit config (.zshrc):
```zsh
zinit light redxtech/zsh-asdf-direnv

# it also works with turbo mode:
zinit ice wait lucid
zinit load redxtech/zsh-asdf-direnv
```

### oh-my-zsh
Install it with your favourite zsh package manager, or clone it directly to your
`$ZSH_CUSTOM/plugins` directory with git, and add `zsh-asdf-direnv` to the plugins
array in your `.zshrc` file:

```zsh
export ASDF_DIR="$HOME/.asdf"
fpath=(${ASDF_DIR}/completions $fpath)

plugins = (... zsh-asdf-direnv)
```

## Usage
Once it's loaded it your shell you should be able to use both asdf and direnv as normal.

If asdf hasn't been installed yet, it will be installed for you (`git clone` into ~/.asdf).

If direnv hasn't been installed yet, it will be installed for you (`asdf plugin add direnv`
& `asdf install direnv latest`).

## Config
If you set the environment variable `ZSH_ASDF_DIRENV_LIBONLY` to `"true"`, it will only add
`$ASDF_DIR/bin` to path and source `$ASDF_DIR/lib/asdf.sh` in order to not put `$ASDF_DIR/shims`
in the path. Read [this](https://github.com/asdf-community/asdf-direnv#pro-tips) for more information.

## Author
**asdf-direnv** © [Gabe Dunn](https://github.com/redxtech), Released under the [MIT](./license.md) License.

