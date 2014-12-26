use v6;
use Test;
use _007::Test;

{
    my $program = q:to/./;
        macro foo() {
        }
        .

    outputs
        $program,
         "",
        "defining macro works";
}

{
    my $program = q:to/./;
        macro foo() {
            return Q::Expr::Call::Sub(
                Q::Term::Identifier("say"),
                Q::Arguments([Q::Literal::Str("OH HAI")])
            );
        }

        foo();
        .

    outputs
        $program,
        "OH HAI\n",
        "expanding a macro and running the result at runtime";
}

{
    my $program = q:to/./;
        macro twice(st) {
            return Q::Statements([st, st]);
        }

        twice( say("wow!") );
        .

    outputs
        $program,
        "wow!\nwow!\n",
        "macros fuzz the border between expressions, statement, and statements";
}

done;
