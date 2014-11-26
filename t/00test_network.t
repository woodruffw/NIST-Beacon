use Test::More;
BEGIN { plan tests => 2 }

use Net::Ping;
use LWP::UserAgent;

my $ping = Net::Ping->new();

isnt($ping->ping("nist.gov", 3), undef);

my $browser = LWP::UserAgent->new;
my $response = $browser->get("http://nist.gov");

ok($response->code == 200);
