set -U fish_greeting
set HOMEBREW_NO_ENV_HINTS "true"

function arx
    arxed
end
function arxed
    cd "$HOME/arxed"
end

function vim
	nvim $argv
end
function diff
	git diff
end

function update_branch
    git pull origin main
end

function remove_branches
	git branch | xargs git branch -D
end

function pbcopy
	xsel --clipboard --input
end

function pbpaste
	xsel --clipboard --output
end

function commit
    if test (count $argv) -eq 0
        echo "Please, provide commit message"
        return 1
    end

    git add --all
    if git commit -m (string join ' ' $argv)
        return 0
    else
        echo "Commit failed."
        return 1
    end
end

function send
    commit $argv
    if test $status -ne 0
        return 1
    end

    set current_branch (git branch --show-current)
    if git push origin $current_branch
        return 0
    else
        echo "Push failed."
        return 1
    end
end

function fuck -d "Correct your previous console command"
  set -l fucked_up_command $history[1]
  env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command THEFUCK_ARGUMENT_PLACEHOLDER $argv | read -l unfucked_command
  if [ "$unfucked_command" != "" ]
    eval $unfucked_command
    builtin history delete --exact --case-sensitive -- $fucked_up_command
    builtin history merge
  end
end

if status is-interactive

end

fish_add_path /usr/bin/ruby
fish_add_path "$HOME/.local/share/gem/ruby/3.0.0/bin"
fish_add_path "/usr/local/go/bin"
fish_add_path /opt/homebrew/bin
fish_add_path "$HOME/.nvm/v22.14.0/bin"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
fzf_configure_bindings --directory=\ct
# 

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dmytro/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/dmytro/Downloads/google-cloud-sdk/path.fish.inc'; end
