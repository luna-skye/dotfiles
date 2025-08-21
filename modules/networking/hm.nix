{ helpers, ... }: {
  imports = [];
  
  options.zen.networking = {
    allowSSH = helpers.mkBooleanOption false "Whether to allow SSH connections for this user";
  };

  config = {};
}
