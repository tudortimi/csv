module dummy_unit_test;

    import svunit_pkg::svunit_testcase;
    `include "svunit_defines.svh"

    string name = "dummy_ut";
    svunit_testcase svunit_ut;


    import csv::*;


    function void build();
        svunit_ut = new(name);
    endfunction


    task setup();
        svunit_ut.setup();
    endtask


    task teardown();
        svunit_ut.teardown();
    endtask


    `SVUNIT_TESTS_BEGIN

        `SVTEST(is_compilable)
            `FAIL_IF_LOG(0, "Test won't compile if production code isn't compilable")
        `SVTEST_END

    `SVUNIT_TESTS_END

endmodule
