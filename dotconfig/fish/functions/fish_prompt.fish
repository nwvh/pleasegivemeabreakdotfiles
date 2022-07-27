function fish_prompt
  # Setup colors
  set -l normal (set_color normal)
  set -l bold (set_color --bold)
  set -l cat (set_color 6c7086)
  set -l white (set_color FFFFFF)
  set -l turquoise (set_color 5fdfff)
  set -l orange (set_color df5f00)
  set -l hotpink (set_color df005f)
  set -l blue (set_color 53D1ED)
  set -l green (set_color 87ff00)
  set -l greeno (set_color -o 87ff00)
  set -l purple (set_color af5fff)
  set -l red (set_color FF0000)
  set -l redo (set_color -o FF0000)
  set -l yellow (set_color E0D757)
  set -l pink (set_color FF00E6)
  set -l __work_dir (string replace $HOME '~' (pwd)) 


function _tide_item_cmd_duration
    test $CMD_DURATION -gt $tide_cmd_duration_threshold && time=(math --scale=0 "$CMD_DURATION/3600000" # Hours
        math --scale=0 "$CMD_DURATION/60000"%60 # Minutes
        math --scale=$tide_cmd_duration_decimals "$CMD_DURATION/1000"%60) if test $time[1] != 0
        _tide_print_item cmd_duration $tide_cmd_duration_icon' ' "$time[1]h $time[2]m $time[3]s"
    else if test $time[2] != 0
        _tide_print_item cmd_duration $tide_cmd_duration_icon' ' "$time[2]m $time[3]s"
    else
        _tide_print_item cmd_duration $tide_cmd_duration_icon' ' "$time[3]s"
    end
end 
  # Env
  set -l last_status $status
  set -l __work_dir (string replace $HOME '~' (pwd))
 
 

  echo -sne \
    ' '$white \
    ' '$bold$cat$__work_dir$turquoise \
    (__fish_git_prompt) \
    ''$__exit_code \
    '' \
    ' '$green❱❱$green❱ ' '\
    $__prompt;

  
end
