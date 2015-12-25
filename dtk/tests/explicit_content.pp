class class1()
{
  $content = {'ab' => [1,2]}
  dtk::export_variable { 'class1::var':
    content => $content
  }
}

include 'class1'