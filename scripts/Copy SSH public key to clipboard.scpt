set ssh_key to "~/.ssh/id_dsa.pub"
try
  do shell script "pbcopy <" & ssh_key
end try
open location "x-launchbar:hide"