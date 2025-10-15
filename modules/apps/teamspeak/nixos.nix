{ helpers, ... }:


{
  options.zen.apps.teamspeak = {
    enable = helpers.mkBooleanOption false "Whether to install the TeamSpeak 6 Client";
  };
}
