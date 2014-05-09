# == Define: chattr::attribute_remove
#
define chattr::attribute_remove (
  $attribute = 'i',
) {

  validate_re($attribute,'^[a-zA-Z]{1}$',"chattr::attribute_remove::${name} is ${attribute}. Attribute must be a single letter. See CHATTR(1).")

  Exec <| tag == 'chattr_attribute_remove' |> -> File <||>
  Exec <| tag == 'chattr_attribute_remove' |> -> Host <||>
  Exec <| tag == 'chattr_attribute_remove' |> -> Resources <||>

  exec { "chattr -i ${name}":
    path   => '/bin:/usr/bin:/sbin:/usr/sbin',
    onlyif => "lsattr ${name} | awk \'{print \$1}\' |grep ${attribute}",
    tag    => 'chattr_attribute_remove',
  }
}
