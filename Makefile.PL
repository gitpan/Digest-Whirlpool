use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME' => 'Digest::Whirlpool',
    'VERSION_FROM' => 'Whirlpool.pm',
    'PREREQ_PM' => {'MIME::Base64' => '0'},
    'AUTHOR' => 'Julius C. Duque',
    'LIBS' => [''],
    'DEFINE' => '',
    'INC' => '-I.',
    'dist' => {'COMPRESS' => 'gzip -9f', 'SUFFIX' => 'gz'}
);

