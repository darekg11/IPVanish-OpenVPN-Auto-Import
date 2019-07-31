for filename in imports/*.ovpn; do
  cat template.txt >> "$filename"
done
