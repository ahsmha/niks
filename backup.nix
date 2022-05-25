let
  syncTimerUnit = {
    username,
    src,    
    name,  
    frequent ? true,
  }: {
    description = "Sync ${name} (from ${src} via ${username})";

    startAt = if frequent then "*:0,7,15,22,30,37,45,52" else "hourly";
    after = [ "network.target" ];

    path = [ pkgs.rsync pkgs.openssh ];
    serviceConfig = {
      User = "root";
      ExecStart = "${pkgs.rsync}/bin/rsync -a -r ${username}@server:${src} /backup/${name}";
    };
  };
in
{

  systemd.services.syncMaildir = syncTimerUnit {
    username = "virtualMail";
    src = "/var/lib/virtualMail";
    name = "virtualMail";
  };
  systemd.services.syncDKIM = syncTimerUnit {
    username = "root";
    src = "/var/lib/dkim";
    name = "dkim";
    frequent = false;
  };
  systemd.services.syncPostgresWalE = syncTimerUnit {
    username = "postgres";
    src = "/var/WALE";
    name = "wal_e";
  };
}
