name             "hipsnip-s3cmd"
maintainer       "HipSnip"
maintainer_email "adam@hipsnip.com"
license          "Apache 2.0"
description      "Installs/Configures s3cmd for a given set of users"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

attribute "s3cmd/users",
  :display_name => "S3cmd Users",
  :description => "The list of user accounts to setup s3cmd for",
  :type => "array",
  :default => [ "root" ]

attribute "s3cmd/bucket_location",
  :display_name => "S3cmd Bucket Location",
  :description => "The Amazon S3 zone we're connecting to",
  :type => "string",
  :default => "EU"