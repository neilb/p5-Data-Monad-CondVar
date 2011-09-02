use strict;
use warnings;
use Data::Monad::List;
use Test::More;

sub eq_sets($$) {
    my ($sets1, $sets2) = @_;

    @$sets1 == @$sets2 or return;
    for my $set (@$sets1) {
        return unless grep {eq_array $set, $_} @$sets2;
    }

    return 1;
}

my $list = Data::Monad::List->sequence(list [1, 2], list [3], list [4, 5, 6]);

ok eq_sets(
    $list,
    [[1, 3, 4], [1 ,3, 5], [1, 3, 6], [2, 3, 4], [2, 3, 5], [2, 3, 6]]
);

# check types
isa_ok $list => 'Data::Monad::List';
is ref $list->[0], 'ARRAY';

done_testing;