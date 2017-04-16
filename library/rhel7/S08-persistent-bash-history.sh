#!/bin/bash
cat << \EOF >> /etc/profile
log_bash_persistent_history()
{

HISTTIMEFORMAT="%Y%m%d %T  "

  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}

alias histgrep='cat ~/.persistent_history|grep --color'
PROMPT_COMMAND="run_on_prompt_command"
EOF

#cat << \EOF >> /etc/bashrc
#mkdir -p $HOME/logs > /dev/null > 2>&1
#test "$(ps -ocommand= -p $PPID | awk '{print $1}')" == 'script' || (TERM=dumb script -q -f $HOME/logs/$(date +"%d-%b-%y_%H-%M-%S")_shell.log)
#EOF

cd /tmp/
wget "http://thirdparty.thig.com/log-user-session/log-user-session.zip"
unzip log-user-session.zip
cd log-user-session-master
[ -f ./configure ] || ./autogen.sh
./configure
make
mkdir -p /var/log/user-session/
chmod 700 /var/log/user-session
chmod 600 /var/log/user-session/*
echo "LogFile = /var/log/user-session/%h-%u-%y%m%d-%H%M%S-%c-%p.log" >> /etc/log-user-session.conf 
echo "ForceCommand log-user-session" >> /etc/ssh/sshd_config

make install


cat << \EOF > /bin/viewks
#!/bin/bash
egrep -v "\.\.\.\.\.\.\.|inflating|extracting|creating|^jdk1.|^apache-tomcat-" /root/ks-post.log | grep --color=always -E '^|Attempting to run | saved ' | less -r
EOF
chmod +x /bin/viewks
ln -s /bin/viewks /root/viewks

mkdir /var/log/sshd-logs
