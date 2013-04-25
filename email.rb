require 'net/smtp'

filename = "/Users/healthlab/ci_vm/ci_poll/vagrant.ci.plist.log"
# Read a file and encode it into base64 format
filecontent = File.read(filename)
encodedcontent = [filecontent].pack("m")   # base64

time = Time.now.getutc
from = "cypress-dev-list@lists.mitre.org"
to = "cypress-dev-list@lists.mitre.org"

if ARGV[0] == "failure"
	status = "Failed"
elsif ARGV[0] == "success"
	status = "Successful"
else
	puts "You must include either \"success\" or \"failure\" as an argument"
	abort
end

marker = "AUNIQUEMARKER"

body =<<EOF
Cypress Install Script CI #{status}
EOF

# Define the main headers.
part1 =<<EOF
From: #{from}
To: #{to}
Subject: Cypress Install Script CI #{status}
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=#{marker}
--#{marker}
EOF

# Define the message action
part2 =<<EOF
Content-Type: text/plain
Content-Transfer-Encoding:8bit

#{body}
--#{marker}
EOF

# Define the attachment section
part3 =<<EOF
Content-Type: multipart/mixed; name=\"#{filename}\"
Content-Transfer-Encoding:base64
Content-Disposition: attachment; filename="#{filename}"

#{encodedcontent}
--#{marker}--
EOF

mailtext = part1 + part2 + part3
 
Net::SMTP.start('mail.mitre.org') {|smtp| smtp.send_message(mailtext, from, to)}  