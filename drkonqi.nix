final: prev: {
  kdePackages = prev.kdePackages // {
    drkonqi = prev.kdePackages.drkonqi.overrideAttrs (prevAttrs: {
      patches = prevAttrs.patches or [ ] ++ [ ./0001-processor-quit-when-atLogEnd-is-reached.patch ];
    });
  };
}
