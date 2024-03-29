grepr(){
  grep -r "$1" app/ lib/ script/ vendor/plugins spec/ config/
}

clear_assets(){
  git checkout -- ./public/assets/javascripts/*.js ./public/assets/javascripts/*.min.js ./public/assets/stylesheets/*.css
}

function countdown(){
  tmux set -g status-interval 1
  date1=$((`date +%s` + $1));
  while [ "$date1" -ge `date +%s` ]; do
    echo -e "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)⏲" >> $TMUX_BOX;
    sleep 0.1
  done
  tmux set -g status-interval 15
  echo " " >> $TMUX_BOX
}

function plantuml(){
  java -jar ~/dotfiles/bin/plantuml.jar $1
}

# Search all files in TOPDIR for PATTERN and replace it with REPLACEMENT
#
#   ex: replace foo by bar in all files under app/example/ directory
#       sr "foo" "bar" app/example
function sr(){
  PATTERN=$1
  REPLACEMENT=$2
  TOPDIR=$3

  find $TOPDIR -type f -name '*' \
    -exec grep -q "$PATTERN" {} \; \
    -exec vim -c "%s/$PATTERN/$REPLACEMENT/gc" -c 'wq' {} \;
}
