let () =
  Echo.set_out (File "debug.log");
  Echo.trace "Checking sync state for '%s' (%d files)" "documents/" 42;
  Echo.info "Starting sync from '%s' to '%s'" "/home/user/docs" "/backup/docs";

  Dummie.dummie_c_fn ();

  Echo.warn "File '%s' is %d days old, skipping..." "notes_old.txt" 120;
  Echo.error "Failed to sync '%s': %s" "report.pdf" "Permission denied";
  Echo.fatal "Aborting sync: required path '%s' not found" "/mnt/backup"
