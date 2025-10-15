{
  fans = [
    { id = "case_fans";
      hwmon = {
        platform = "nct6797";
        rpmChannel = 3;
        pwmChannel = 3;
      };
      startPwm = 100;
      neverStop = true;
      curve = "case_curve";
    }
  ];

  sensors = [
    { id = "cpu_package";
      hwmon = { platform = "k10temp-pci-00c3"; index = 1; };
    }
    { id = "gpu_package";
      hwmon = { platform = "amdgpu-pci"; index = 2; };
    }
  ];

  curves = [
    { id = "cpu_curve";
      linear = {
        sensor = "cpu_package";
        min = 40;
        max = 75;
      };
    }
    { id = "gpu_curve";
      linear = {
        sensor = "gpu_package";
        min = 45;
        max = 75;
      };
    }
    { id = "case_curve";
      function = {
        type = "maximum";
        curves = [ "cpu_curve" "gpu_curve" ];
      };
    }
  ];
}
