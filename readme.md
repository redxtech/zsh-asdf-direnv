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
plugins=(... zsh-asdf-direnv)
```

## Usage
Once it's loaded it your shell you should be able to use both asdf and direnv as normal.

If asdf hasn't been installed yet, it will be installed for you (`git clone` into ~/.asdf).

If direnv hasn't been installed yet, it will be installed for you (`asdf plugin add direnv`
& `asdf install direnv latest`).

## Author
**asdf-direnv** © [Gabe Dunn](https://github.com/redxtech), Released under the [MIT](./license.md) License.

