class rkhunter  (
  $rotate_mirrors         = $rkhunter::params::rotate_mirrors,
  $update_mirrors         = $rkhunter::params::update_mirrors,
  $mirrors_mode           = $rkhunter::params::mirrors_mode,
  $mail_on_warning        = $rkhunter::params::mail_on_warning,
  $mail_cmd               = $rkhunter::params::mail_cmd,
  $tmpdir                 = $rkhunter::params::tmpdir,
  $dbdir                  = $rkhunter::params::dbdir,
  $scriptdir              = $rkhunter::params::scriptdir,
  $bindir                 = $rkhunter::params::bindir,
  $logfile                = $rkhunter::params::logfile,
  $append_log             = $rkhunter::params::append_log,
  $copy_log_on_error      = $rkhunter::params::copy_log_on_error,
  $use_syslog             = $rkhunter::params::use_syslog,
  $color_set2             = $rkhunter::params::color_set2,
  $auto_x_detect          = $rkhunter::params::auto_x_detect,
  $whitelisted_is_white   = $rkhunter::params::whitelisted_is_white,
  $allow_ssh_root_user    = $rkhunter::params::allow_ssh_root_user,
  $allow_ssh_prot_v1      = $rkhunter::params::allow_ssh_prot_v1,
  $enable_tests           = $rkhunter::params::enable_tests,
  $disable_tests          = $rkhunter::params::disable_tests,
  $immutable_set          = $rkhunter::params::immutable_set,
  $allow_syslog_remote_logging = $rkhunter::params::allow_syslog_remote_logging,
  $suspscan_temp          = $rkhunter::params::suspscan_temp,
  $suspscan_maxsize       = $rkhunter::params::suspscan_maxsize,
  $suspscan_thresh        = $rkhunter::params::suspscan_thresh,
  $use_locking            = $rkhunter::params::use_locking,
  $lock_timeout           = $rkhunter::params::lock_timeout,
  $show_lockmsgs          = $rkhunter::params::show_lockmsgs,
  $disable_unhide         = $rkhunter::params::disable_unhide,
  $installdir             = $rkhunter::params::installdir,
  $ssh_config_dir         = $rkhunter::params::ssh_config_dir,
  $hash_cmd               = $rkhunter::params::hash_cmd,
  $hash_fld_idx           = $rkhunter::params::hash_fld_idx,
  $package_manager        = $rkhunter::params::package_manager,
  $pkgmgr_no_verfy        = $rkhunter::params::pkgmgr_no_verfy,
  $ignore_prelink_dep_err = $rkhunter::params::ignore_prelink_dep_err,
  $use_sunsum             = $rkhunter::params::use_sunsum,
  $existwhitelist         = $rkhunter::params::existwhitelist,
  $attrwhitelist          = $rkhunter::params::attrwhitelist,
  $writewhitelist         = $rkhunter::params::writewhitelist,
  $scan_mode_dev          = $rkhunter::params::scan_mode_dev,
  $phalanx2_dirtest       = $rkhunter::params::phalanx2_dirtest,
  $inetd_conf_path        = $rkhunter::params::inetd_conf_path,
  $inetd_allowed_svc      = $rkhunter::params::inetd_allowed_svc,
  $xinetd_conf_path       = $rkhunter::params::xinetd_conf_path,
  $xinetd_allowed_svc     = $rkhunter::params::xinetd_allowed_svc,
  $startup_paths          = $rkhunter::params::startup_paths,
  $passwd_file            = $rkhunter::params::passwd_file,
  $user_fileprop_files_dirs = $rkhunter::params::user_fileprop_files_dirs,
  $rtkt_file_whitelist    = $rkhunter::params::rtkt_file_whitelist,
  $rtkt_dir_whitelist     = $rkhunter::params::rtkt_dir_whitelist,
  $os_version_file        = $rkhunter::params::os_version_file,
  $stat_cmd               = $rkhunter::params::stat_cmd,
  $readlink_cmd           = $rkhunter::params::readlink_cmd,
  $web_cmd                = $rkhunter::params::web_cmd,
  $scanrootkitmode        = $rkhunter::params::scanrootkitmode,
  $unhide_tests           = $rkhunter::params::unhide_tests,
  $unhidetcp_opts         = $rkhunter::params::unhidetcp_opts,
  $scriptwhitelist        = $rkhunter::params::scriptwhitelist,
  $immutewhitelist        = $rkhunter::params::immutewhitelist,
  $allowhiddendir         = $rkhunter::params::allowhiddendir,
  $allowhiddenfile        = $rkhunter::params::allowhiddenfile,
  $allowprocdelfile       = $rkhunter::params::allowprocdelfile,
  $allowproclisten        = $rkhunter::params::allowproclisten,
  $allowpromiscif         = $rkhunter::params::allowpromiscif,
  $allowdevfile           = $rkhunter::params::allowdevfile,
  $allowipcproc           = $rkhunter::params::allowipcproc,
  $allowipcpid            = $rkhunter::params::allowipcpid,
  $allowipcuser           = $rkhunter::params::allowipcuser,
  $ipc_seg_size           = $rkhunter::params::ipc_seg_size,
  $uid0_accounts          = $rkhunter::params::uid0_accounts,
  $pwdless_accounts       = $rkhunter::params::pwdless_accounts,
  $syslog_config_file     = $rkhunter::params::syslog_config_file,
  $app_whitelist          = $rkhunter::params::app_whitelist,
  $suspscan_dirs          = $rkhunter::params::suspscan_dirs,
  $port_whitelist         = $rkhunter::params::port_whitelist,
  $port_path_whitelist    = $rkhunter::params::port_path_whitelist,
  $warn_on_os_change      = $rkhunter::params::warn_on_os_change,
  $updt_on_os_change      = $rkhunter::params::updt_on_os_change,
  $shared_lib_whitelist   = $rkhunter::params::shared_lib_whitelist,
  $show_summary_warnings_number = $rkhunter::params::show_summary_warnings_number,
  $show_summary_time      = $rkhunter::params::show_summary_time,
  $empty_logfiles         = $rkhunter::params::empty_logfiles,
  $missing_logfiles       = $rkhunter::params::missing_logfiles,


) inherits ::rkhunter::params {
  include ::rkhunter::packages

  file { '/etc/rkhunter.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('rkhunter/etc/rkhunter.conf.erb');
  }
}