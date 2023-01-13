DIRECTORY=$HOME
if [ -d "$DIRECTORY" ] ; then
  cd $DIRECTORY
  file=$(fd | dmenu -l 10)
  if [ -n "$file" ] && [ -f "$file" ] ; then
    xdg-open "$file";
  fi
fi
