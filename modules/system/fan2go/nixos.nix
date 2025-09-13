{ helpers, ... }:


{
  options.zen.system.fan2go = {
    enable = helpers.mkBooleanOption false "Whether to enable the fan2go fan controlling daemon";
  };
}
