class class1()
{
  $var = {'ab' => [1,2]}
  dtk::export_variable { 'class1::var': }
}

include 'class1'