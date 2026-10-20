# 1. ENVIRONMENT
# Respect values exported by the login manager or compositor:
#? These are defaults for programs started from Fish, not a replacement for the
#? compositor/session's environment configuration.
set -q GTK_USE_PORTAL; or set -gx GTK_USE_PORTAL 1
set -q MOZ_ENABLE_WAYLAND; or set -gx MOZ_ENABLE_WAYLAND 1
set -q QT_QPA_PLATFORMTHEME; or set -gx QT_QPA_PLATFORMTHEME qt6ct

# Default editor for CLI tools (Git commit messages, interactive tools, etc.):
if not set -q EDITOR
    if type -q nvim
        set -gx EDITOR nvim
    else if type -q vi
        set -gx EDITOR vi
    end
end
if not set -q VISUAL; and set -q EDITOR
    set -gx VISUAL "$EDITOR"
end

# Prefer less for paging when installed. Respect an existing PAGER:
if not set -q PAGER
    if type -q less
        set -gx PAGER less
    else
        set -gx PAGER cat
    end
end

# 2. PATH
#? fish_add_path ignores directories that do not exist and prevents duplicate
#? entries. --move also prioritizes entries already present in PATH.
#? Desired priority: ~/.local/bin, ~/.cargo/bin, ~/go/bin.
fish_add_path --move --prepend \
    "$HOME/.local/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/go/bin"

# 3. INTERACTIVE SHELL
if status is-interactive
    #? Suppress Fish's default greeting; Starship provides prompt context.
    set -g fish_greeting

    # Elaris theme(Fish command-line highlighting and completion pager):
    #? This theme does not configure Starship's prompt colors; that is done
    #? separately in ~/.config/starship.toml if desired.
    if type -q fish_config; and test -f "$__fish_config_dir/themes/elaris.theme"
        fish_config theme choose elaris --color-theme=dark >/dev/null 2>&1
    end

    # Starship prompt:
    if type -q starship
        starship init fish | source
    end

    # Zoxide directory navigation:
    #? Replaces `cd` with zoxide-aware navigation. For classic `cd` plus
    #? `z`/`zi`, use `zoxide init fish | source` instead.
    if type -q zoxide
        zoxide init fish --cmd cd | source
    end

    # Abbreviations
    #? Fish expands abbreviations on the command line so the expanded command
    #? can be inspected or edited before execution.

    # Git: status, diffs, staging, commits, history:
    abbr --add --global g      'git'
    abbr --add --global gs     'git status --short --branch'
    abbr --add --global gss    'git status'
    abbr --add --global gd     'git diff'
    abbr --add --global gds    'git diff --staged'
    abbr --add --global ga     'git add'
    abbr --add --global gaa    'git add --all'
    abbr --add --global gc     'git commit'
    abbr --add --global gcm    'git commit -m'
    abbr --add --global gl     'git log --oneline --decorate -20'
    abbr --add --global glo    'git log --oneline --decorate --graph --all'
    abbr --add --global gsh    'git show'

    # Git(remotes and branch management). Force-with-lease still rewrites
    # remote history; use only when that is intentional:
    abbr --add --global gp     'git push'
    abbr --add --global gpl    'git pull --ff-only'
    abbr --add --global gpf    'git push --force-with-lease'
    abbr --add --global gsw    'git switch'
    abbr --add --global gsc    'git switch -c'
    abbr --add --global gsm    'git switch main'
    abbr --add --global gb     'git branch'
    abbr --add --global gba    'git branch --all'
    abbr --add --global gbd    'git branch -d'
    abbr --add --global gco    'git checkout'
    abbr --add --global gst    'git stash push'
    abbr --add --global gsp    'git stash pop'

    # General shell shortcuts:
    abbr --add --global l      'ls'
    abbr --add --global c      'clear'
    abbr --add --global h      'history'
    abbr --add --global q      'exit'
    abbr --add --global ..     'cd ..'
    abbr --add --global ...    'cd ../..'
    abbr --add --global ....   'cd ../../..'

    # Optional tools:
    #! Only define abbreviations when the tool is installed.
    if type -q nvim
        abbr --add --global v   'nvim'
        abbr --add --global vim 'nvim'
        abbr --add --global vi  'nvim'
    end

    if type -q lazygit
        abbr --add --global lg 'lazygit'
    end

    if type -q bat
        abbr --add --global catp 'bat --paging=never'
    end

    if type -q python3
        abbr --add --global py 'python3'
    end

    if type -q uv
        abbr --add --global uvr 'uv run'
        abbr --add --global uvs 'uv sync'
        abbr --add --global uvt 'uv run pytest'
        abbr --add --global uva 'uv add'
        abbr --add --global uvd 'uv add --dev'
    end

    if type -q docker
        abbr --add --global dps 'docker ps'
        abbr --add --global dcu 'docker compose up'
        abbr --add --global dcud 'docker compose up -d'
        abbr --add --global dcd 'docker compose down'
        abbr --add --global dcl 'docker compose logs --follow'
        abbr --add --global dce 'docker compose exec'
    end

    if type -q kubectl
        abbr --add --global k 'kubectl'
        abbr --add --global kgp 'kubectl get pods'
        abbr --add --global kgs 'kubectl get services'
        abbr --add --global kctx 'kubectl config current-context'
    end

    #? direnv loads per-project environment settings from trusted .envrc files.
    #! Inspect a project's .envrc before running `direnv allow`.
    if type -q direnv
        set -g direnv_fish_mode eval_on_arrow
        direnv hook fish | source
    end

    # Zellij auto-start belongs last so it can replace the interactive shell:
    #! Disable for a one-off shell: env ZELLIJ_DISABLE_AUTO_START=1 fish
    #! Avoid nesting if already inside a Zellij session.
    if type -q zellij; and not set -q ZELLIJ_DISABLE_AUTO_START; and not set -q ZELLIJ
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
