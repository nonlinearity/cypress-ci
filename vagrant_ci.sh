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
    /Users/healthlab/.rvm/rubies/ruby-1.9.3-p392/bin/ruby email.rb failure >> /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log
    echo "Failure email sent" >> /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log
else
	/Users/healthlab/.rvm/rubies/ruby-1.9.3-p392/bin/ruby email.rb success >> /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log
	echo "Success email sent" >> /Users/healthlab/ci_vm/ci_poll/vagrant_ci.log
fi

cd /Users/healthlab/ci_vm/test
vagrant destroy

rm /Users/healthlab/ci_vm/ci_poll/vagrant.ci.plist.log