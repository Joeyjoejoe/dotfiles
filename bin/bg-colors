for i in {0..255}; do
  printf '\e[48;5;%dm%3d ' $i $i;
  (((i+3) % 18)) || printf '\e[0m\n';
done
