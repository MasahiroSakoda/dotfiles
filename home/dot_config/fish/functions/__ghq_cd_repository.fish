# -*-mode:fish-*- vim:ft=fish

function __ghq_cd_repository -d "Change local repository directory"
  ghq list --full-path | fzf | read -l repo_path
  if [ $repo_path ]
    cd $repo_path
  end
end
