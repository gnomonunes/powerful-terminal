source ~/.git-completion.sh
source ~/.git-parse-branch.sh

alias ls="ls -GF"
alias ll="ls -GFla"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

foldersize()
{
	FILES=$(ls -lrt | awk 'BEGIN { total = 0 }; { total += $5 }; END { print total }')

	if [ $FILES -eq 0 ]; then
		echo "0 bytes"
		return
	fi

	VIN=$(echo "$FILES")

	SLIST="bytes,KB,MB,GB,TB,PB,EB,ZB,YB"

	POWER=1
	VAL=$( echo "scale=2; $VIN / 1" | bc)
	VINT=$( echo $VAL / 1024 | bc )
	while [ $VINT -gt 0 ]
	do
	    let POWER=POWER+1
	    VAL=$( echo "scale=2; $VAL / 1024" | bc)
	    VINT=$( echo $VAL / 1024 | bc )
	done

	echo $VAL $( echo $SLIST | cut -f$POWER -d, )
}

totalfiles()
{
	TOT=$(ls -1A | wc -l | awk {'print $1'})

	if [[ $TOT -gt 1 ]]; then
		echo "$TOT items"
	else
		echo "$TOT item"
	fi
}

set_prompt(){
    PS1="\[\033[0;90m\]╔╡ \[\033[1;32m\][\\t]\[\033[00m\] \[\033[0;90m\]║\[\033[00m\] \[\033[00m\]\[\033[0;34m\]\w\[\033[00m\] \[\033[0;90m\]($(totalfiles), $(foldersize))\[\033[00m\] $(git-parse-branch)\n\[\033[0;90m\]╚»\[\033[00m\] "
}

PROMPT_COMMAND=set_prompt
