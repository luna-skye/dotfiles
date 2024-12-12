function qr -d "Encode the first input argument as a QR Code"
  echo $argv[1] | curl -F-=\<- qrenco.de
end
