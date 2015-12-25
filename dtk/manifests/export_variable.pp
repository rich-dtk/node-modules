define dtk::export_variable(
  $content = undef
)
{
  if $content == undef {
    $final_content = 'undef'
  } else {
    $final_content = $content
  }
  dtk_export_variable($name, $final_content)
}
