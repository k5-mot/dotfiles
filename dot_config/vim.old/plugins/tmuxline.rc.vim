"let g:tmuxline_preset = 'full'
let g:tmuxline_preset = {
      \'a'    : ['\ue795 #(whoami)@#h'],
      \'b'    : ['S:#S', 'P:#P'],
      \'c'    : ['#{battery_icon_status}', '#{cpu_icon} #{cpu_percentage}', '#{gpu_icon} #{gpu_percentage}', ''],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'x'    : [' ', '#{net_speed}', '#{online_status}'],
      \'y'    : ['\uf073 %Y/%m/%d (%a)', '\uf017 %H:%M:%S'],
      \'z'    : ['#(os_icon.sh) #(os_name.sh)']}
let g:tmuxline_theme = 'gruvbox_material'

"\'x'    : ['#{online_status}', '#{net_speed}', '#{cpu_icon} #{cpu_percentage}', '#{gpu_icon} #{gpu_percentage}', '#{battery_icon_status}'],
