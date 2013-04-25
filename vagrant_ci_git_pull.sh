cd /Users/healthlab/ci_vm/ci_poll
rm Vagrant_ci_git_pull.log

date >> /Users/healthlab/ci_vm/ci_poll/Vagrant_ci_git_pull.log
export http_proxy=http://gatekeeper.mitre.org:80
export https_proxy=https://gatekeeper.mitre.org:80

cd /Users/healthlab/cypress
git pull --no-edit origin develop >> /Users/healthlab/ci_vm/ci_poll/Vagrant_ci_git_pull.log
echo >> /Users/healthlab/ci_vm/ci_poll/Vagrant_ci_git_pull.log
echo "Vagrant_ci_git_pull.sh ran succesfully" >> /Users/healthlab/ci_vm/ci_poll/Vagrant_ci_git_pull.log