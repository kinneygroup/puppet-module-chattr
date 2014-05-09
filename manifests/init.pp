# == Class: chattr
#
# Hack to get around Puppet's inability to manage files with the immutable attribute set.
#
# https://tickets.puppetlabs.com/browse/PUP-1199
#
class chattr (
  $attribute_adds                = undef,
  $attribute_adds_hiera_merge    = true,
  $attribute_removes             = undef,
  $attribute_removes_hiera_merge = true,
) {

  if type($attribute_adds_hiera_merge) == 'string' {
    $attribute_adds_hiera_merge_real = str2bool($attribute_adds_hiera_merge)
  } else {
    $attribute_adds_hiera_merge_real = $attribute_adds_hiera_merge
  }
  validate_bool($attribute_adds_hiera_merge_real)

  if $attribute_adds != undef {
    if $attribute_adds_hiera_merge_real == true {
      $attribute_adds_real = hiera_hash('chattr::attribute_adds')
    } else {
      $attribute_adds_real = $attribute_adds
    }
    validate_hash($attribute_adds_real)
    create_resources('chattr::attribute_add',$attribute_adds_real)
  }

  if type($attribute_removes_hiera_merge) == 'string' {
    $attribute_removes_hiera_merge_real = str2bool($attribute_removes_hiera_merge)
  } else {
    $attribute_removes_hiera_merge_real = $attribute_removes_hiera_merge
  }
  validate_bool($attribute_removes_hiera_merge_real)

  if $attribute_removes != undef {
    if $attribute_removes_hiera_merge_real == true {
      $attribute_removes_real = hiera_hash('chattr::attribute_removes')
    } else {
      $attribute_removes_real = $attribute_removes
    }
    validate_hash($attribute_removes_real)
    create_resources('chattr::attribute_remove',$attribute_removes_real)
  }
}
