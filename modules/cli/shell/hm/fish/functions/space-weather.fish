#  TODO: add completions based on handpicked image paths
#  TODO: check terminal and warn if not using kitty
function space-weather -d "Displays space weather reports from the NOAA"
  set base_url "https://services.swpc.noaa.gov/images"
  set image_name $argv[1]
  curl -s "$base_url/$image_name" | kitten icat --align left
end
