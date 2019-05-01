# manage polipo on debian
class tor::polipo::freebsd inherits tor::polipo::base {
  Service['polipo'] {
    hasstatus => false,
    pattern   => '/usr/local/bin/polipo',
  }
}
