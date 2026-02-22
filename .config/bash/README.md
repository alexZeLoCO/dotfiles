# Custom Bash Prompt Config

This repository provides a modular Bash prompt and shell setup built around a multi-line status prompt, colored aliases, and blesh-powered line editing/autocomplete.

## What this changes from base Bash

Compared to a default Bash prompt, this configuration:

- Replaces the default `PS1` with a custom multi-line prompt assembled from modules.
- Shows command exit status in the prompt (including blesh-compatible handling).
- Shows user/host, working directory, and current time on every prompt.
- Shows Python virtual environment state in the prompt.
- Shows Git branch + upstream relation when inside a Git repo.
- Shows running background jobs.
- Shows a Docker container summary block when containers are running.
- Overrides common command aliases (`ls`, `cat`, and helper shortcuts).
- Uses `zoxide` initialization for directory jumping.
- Uses `blesh` for advanced editing/completion and prompt compatibility.

## Prompt modules

The prompt is composed in `functions/load_prompt.bashrc` and sources:

- exit status
- decorations
- user/host
- working directory
- time
- venv
- git status
- jobs status
- docker status

## Requirements

Source of truth: comments in `.bashrc`.

### Mandatory

- `bash` (interactive shell)
- `blesh` (required; prompt config is coupled to it)

### Optional / removable

- `bat` (used by alias `cat='bat'`)
- `eza` (used by alias `ls='eza --color=auto'`)
- `git` (required only for Git prompt segment and git aliases)
- `docker` (required only for Docker prompt segment and docker aliases)
- `zoxide` (required only for directory-jump integration)

## How to enable

In your personal `~/.bashrc`, add:

```bash
source "$PATH_TO_THIS_REPO/.bashrc"
```

Then start a new interactive Bash session (or run `source ~/.bashrc`).

## How to disable optional features

### Disable git prompt segment

In `functions/load_prompt.bashrc`, comment out:

```bash
source "$HOME/.config/bash/functions/parts/git_status/git_prompt.bashrc"
```

### Disable docker prompt segment

In `functions/load_prompt.bashrc`, comment out:

```bash
source "$HOME/.config/bash/functions/parts/docker/docker.bashrc"
```

### Disable zoxide

In `.bashrc`, comment out:

```bash
eval "$(zoxide init bash)"
```

### Replace bat/eza

Edit aliases in `aliases.bashrc`:

- Replace `cat='bat'` with `cat='cat'` (or remove alias).
- Replace `ls='eza --color=auto'` with `ls='ls --color=auto'` (or preferred variant).

## Notes on blesh integration

- `.bashrc` loads blesh with `--attach=none`, then attaches after prompt setup.
- `.blerc` is configured to keep your custom PS1 intact.
- Exit status is rendered in the custom prompt, and standalone blesh exit markers are suppressed.

## File layout (high level)

- `.bashrc`: entrypoint (interactive guard, blesh load/attach, aliases/prompt load, zoxide)
- `.blerc`: blesh behavior/settings
- `aliases.bashrc`: shell aliases
- `functions/load_prompt.bashrc`: prompt wiring + PS1 assembly
- `functions/parts/*`: prompt modules
- `functions/style/*`: colors/format helpers
