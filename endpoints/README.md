# File Name Guidelines

Mr Murano allows endpoint file names in any format. However we suggest the following as a convenient standard.

File names format:

`<dasherized URI>_METHOD.lua`
* replace the slashes (`/`) in the URI with dashes
  * surround parameters in the URI with curly braces
* add an underscore (`_`)
* append the HTTP method name
* follow with the file extension `.lua`

By following this guidelines one can tell just by the file name which route they're looking for when debugging, and can avoid naming collisions when creating new routes.