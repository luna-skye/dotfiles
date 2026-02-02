{ osConfig, config }:

{
  position = "center";
  largeButtonsLayout = "grid";
  largeButtonsStyle = false;
  showHeader = true;
  showNumberLabels = true;

  enableCountdown = true;
  countdownDuration = 10000;

  powerOptions = [
    { enabled = true; countdownEnabled = true; action = "lock";      command = ""; }
    { enabled = true; countdownEnabled = true; action = "suspend";   command = ""; }
    { enabled = true; countdownEnabled = true; action = "hibernate"; command = ""; }
    { enabled = true; countdownEnabled = true; action = "reboot";    command = ""; }
    { enabled = true; countdownEnabled = true; action = "logout";    command = ""; }
    { enabled = true; countdownEnabled = true; action = "shutdown";  command = ""; }
  ];
}
