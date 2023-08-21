# ubuntu-setup
This is my personal repo I use for setting up a new Ubuntu machine. I use it for both daily drivers and throwaway VMs (I like to SSH into the VM and play around in it, and when I do that, I like having nice stuff like zsh and rg)

## Setting up a new Ubuntu machine
When setting up Ubuntu, I created the dmitry user.

- [ ] On the machine, install the OpenSSH server.
```bash
sudo apt update
sudo apt install -y openssh-server
```

At this point, password authentication will be enabled, which is what I want because this way I can easily SSH in and edit authorized_keys on the new machine.

- [ ] Now, generate a new ssh key using 1Password. Add the public key to `authorized_keys` on the new machine.

- [ ] Now, create an Ansible user.
  On the new machine:
```bash
sudo adduser ansible
sudo usermod -aG sudo ansible

sudo -u ansible mkdir /home/ansible/.ssh
sudo -u ansible chmod 0700 /home/ansible/.ssh
cat /home/dmitry/.ssh/authorized_keys | sudo -u ansible tee /home/ansible/.ssh/authorized_keys
sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys
```

ansible.cfg reads the become_pass from an environment variable (`ANSIBLE_SUDO_PASS`) which means you can run Ansible without typing in a password, yet without compromising security, like so: `ANSIBLE_SUDO_PASS=$(op item get ansible --fields label=password) ansible-playbook ...`

- [ ] One thing you’ll need to do manually is authenticate GH CLI.
```
gh auth login
# On another computer, visit https://github.com/login/device/
gh auth setup-git
```

- [ ] Now, you can run your Ansible magic against this machine.

- [ ] On the new machine, install oh-my-zsh. I couldn’t figure out how to do it using Ansible.
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- [ ] Also, you will need to install fnm manually. (This is node version manager, so you might not need it)
```
curl -fsSL https://fnm.vercel.app/install | bash
```

- [ ] Finally, you can use pyenv to setup Python.
```
pyenv install 3.11.3
pyenv global 3.11.3
```

- [ ] Install 1Password. Out of laziness, I did these steps manually, but they should be pretty easy to turn into an Ansible playbook. https://support.1password.com/install-linux/#debian-or-ubuntu

- [ ] I also installed Tailscale manually. This would be easy to convert into an Ansible playbook as well.

- [ ] Install [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
  `git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv`

- [ ] Install bpftrace using `ansible/files/install_bpftrace.sh`

- [ ] Install VScode by [downloading the .deb](https://code.visualstudio.com/Download) (yes, also not doing it via ansible out of laziness)

- [ ] Install Anki ([instructions](https://docs.ankiweb.net/platform/linux/installing.html))

- [ ] Manually: change paste shortcut in terminal from <ctrl-shift-v> (seriously, WHO finds this easy to type?) to <ctrl-v> (TODO: somehow do this globally)

