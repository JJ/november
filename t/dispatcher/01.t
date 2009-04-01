use v6;

use Test;
plan 8;

use Dispatcher;
ok(1,'We use Dispatcher and we are still alive');

use Dispatcher::Rule;
ok(1,'We use Dispatcher::Rule and we are still alive');

my $d = Dispatcher.new;

dies_ok( { $d.add: Dispatcher::Rule.new }, 
         '.add adds only complete Rule objects' );

$d.add: Dispatcher::Rule.new( :pattern(''), action => { "Krevedko" } );

is( $d.dispatch(['']), 
    'Krevedko', 
    "Pattern ['']"
);

ok( $d.add( ['foo', 'bar'], { "Yay" } ), 
           '.add(@patterb, &action) -- shortcut for fast add Rule object' );

nok( $d.dispatch(['foo']), 
    'Dispatcher return False if can`t find matched Rule and do not have default' );


is( $d.dispatch(['foo', 'bar']), 
    "Yay", 
    "Dispatch to Rule ['foo', 'bar'])"
);

$d.default = { "Woow" };

is( $d.dispatch(['foo', 'bar', 'baz']), 
    "Woow", 
    'Dispatch to default, when have no matched Rule'  
);

# vim:ft=perl6
