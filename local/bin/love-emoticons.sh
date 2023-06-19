#!/bin/sh

var=$((1 + $RANDOM % 8))

if [[ $var -eq 1 ]]; then
	wl-copy "⠀      ∧,,,∧
	 ( • · • ̳)
	 /   づ♡ I love you"
elif [[ $var -eq 2 ]]; then
	wl-copy " ˗ˋˏ ♡ ˎˊ˗"
elif [[ $var -eq 3 ]]; then
	wl-copy "(づ๑•ᴗ•๑)づ♡"
elif [[ $var -eq 4 ]]; then
	wl-copy "⠀      /)/)                          (\(\\
( . .)                          (. . )
( づLove you forever⊂ )"
elif [[ $var -eq 5 ]]; then
	wl-copy "⠀          /)/)
		( . .)
		c( づ♡づ"
elif [[ $var -eq 6 ]]; then
	wl-copy "⠀         /)  /)
	  (˶•-•˶)  - for u <3
	ପ/づ  づ ~♡︎"
elif [[ $var -eq 7 ]]; then
	wl-copy "♡ (˃͈ દ ˂͈ ༶ )"
elif [[ $var -eq 8 ]]; then 
	wl-copy "∧_____∧ ∧_____∧
(  ~  Ɐ ~)ω <  ) - ♡ 
/         つ⊂    \\"
elif [[ $var -eq 8 ]]; then
	wl-copy "❁્᭄͜͡"
elif [[ $var -eq 9 ]]; then
	wl-copy "ʚ♡⃛ɞ(ू•ᴗ•ू❁)"
fi

notify-send "Copied emotion ${var} to clipboard."

#wl-paste
