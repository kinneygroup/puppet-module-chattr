# == Define: chattr::attribute_add
#
define chattr::attribute_add (
  $attribute = 'i',
) {

  validate_re($attribute,'^[a-zA-Z]{1}$',"chattr::attribute_add::${name} is ${attribute}. Attribute must be a single letter. See CHATTR(1).")

  File <||> -> Exec <| tag == 'chattr_attribute_add' |>
  Host <||> -> Exec <| tag == 'chattr_attribute_add' |>
  Resources <||> -> Exec <| tag == 'chattr_attribute_add' |>

  exec { "chattr +i ${name}":
    path   => '/bin:/usr/bin:/sbin:/usr/sbin',
    unless => "lsattr ${name} | awk \'{print \$1}\' |grep ${attribute}",
    tag    => 'chattr_attribute_add',
  }
}
