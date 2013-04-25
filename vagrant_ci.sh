cd /Users/healthlab/ci_vm/ci_poll
rm vagrant_ci.log
rm post-merge.log

cd /Users/healthlab/ci_vm/test
date >> /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log
vagrant init >> /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log
VAGRANT_LOG=info vagrant up --provider=vmware_fusion >> /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log

cd /Users/healthlab/ci_vm/ci_poll
if grep failed /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log
then
    ruby email.rb failure
    echo "Failure email sent" >> /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log
else
	ruby email.rb success
	echo "Success email sent" >> /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log

fi

rm /Users/healthlab/ci_vm/ci_poll/vagrant.ci.plist.log

cd /Users/healthlab/ci_vm/test
vagrant destroy