requires "AnyEvent" => "0";
requires "EV" => "0";
requires "Import::Base" => "0.012";
requires "Moo" => "2";
requires "Sereal" => "0";
requires "Types::Standard" => "0";
requires "ZMQ::FFI" => "0";
requires "perl" => "5.020";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Test::Deep" => "0";
  requires "Test::More" => "1.001005";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};
