use warnings;
use strict;
use Test::More;
use WebIrc::Core::Util qw/ format_time as_id id_as /;

{
    my $time = 1348308427;
    like(
        format_time($time, '%d-%m-%Y %b %H:%M:%S'),
        qr/22-09-2012 sep\W* 12:07:07/i,
        'format_time(1348308427)'
    );
}

{
  is as_id('#foo=123'), ':23foo:3d123', 'as_id #foo';
  is as_id('target."', '4' => '#foo'), 'target:2e:22:004:00:23foo', 'as_id target 4 #foo';
  is as_id('foo'), 'foo', 'as_id foo';
  is as_id('conver:sation', '4' => '#foo'), 'conver:3asation:004:00:23foo', 'as_id target 4 foo';

  is_deeply [id_as(':23foo:3d123')], ['#foo=123'], 'id_as g_foo-61123';
  is_deeply [id_as('target:2e:22:004:00:23foo')], ['target."', '4', '#foo'], 'id_as g_target-46-34_4_foo';
  is_deeply [id_as('conver:3asation:004:00:23foo')], ['conver:sation', '4', '#foo'], 'id_as s_conversation_4_foo';
}

{
  like 'localhost', $WebIrc::Core::Util::host_re, 'localhost is valid';
  like 'localhost:123', $WebIrc::Core::Util::host_re, 'localhost:123 is valid';
  like 'irc.perl.org', $WebIrc::Core::Util::host_re, 'irc.perl.org is valid';
  like 'irc.perl.org:6667', $WebIrc::Core::Util::host_re, 'irc.perl.org:6667 is valid';
  like 'loopback', $WebIrc::Core::Util::host_re, 'loopback is valid';
  ok 'loop' !~ $WebIrc::Core::Util::host_re, 'loop is invalid';
  ok 'foo:6667' !~ $WebIrc::Core::Util::host_re, 'foo:6667 is invalid';
}

done_testing;
