function log_sensors -d "Logs CPU/GPU information to file in home dir"
  set ts (date +"%Y-%m-%d_%H-%M-%S")
  set outdir ~/sensor-logs
  mkdir -p $outdir
  set outfile "$outdir/$ts.log"

  # get cpu hwmon temperature
  set cpu_temp_path (grep -m1 "k10temp" -l /sys/class/hwmon/hwmon*/name | sed 's/name/temp1_input/')
  if test -z "$cpu_path"
    echo (set_color red)"Could not find CPU package temp in /sys/class/hwmon"(set_color normal)
    return 1
  end

  # get gpu hwmon temperature
  set gpu_temp_path (grep -m1 "amdgpu" -l /sys/class/hwmon/hwmon*/name | sed 's/name/temp2_input/')
  if test -z "$gpu_path"
    echo (set_color red)"Could not find GPU package temp in /sys/class/hwmon"(set_color normal)
    return 1
  end

  # log per second
  echo "Logging to "(set_color green)"$outfile "(set_color red)"(ctrl+c to stop)"(set_color normal)
  while true
    set ts (date +%s)

    set cpu (math --scale 2 (cat $cpu_temp_path) / 1000.0)
    set gpu (math --scale 2 (cat $gpu_temp_path) / 1000.0)

    echo (set_color yellow)"[$ts] "(set_color green)"CPU: $cpu "(set_color cyan)"GPU: $gpu"(set_color normal)
    echo "$ts $cpu $gpu" >> $outfile
    sleep 1
  end
end
