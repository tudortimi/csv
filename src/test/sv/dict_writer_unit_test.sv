module dict_writer_unit_test;

    import svunit_pkg::svunit_testcase;
    `include "svunit_defines.svh"

    string name = "dict_writer_ut";
    svunit_testcase svunit_ut;


    import csv::*;

    dict_writer writer;
    bit[31:0] fd;


    function void build();
        svunit_ut = new(name);

        fd = $fopen("output.csv");
        writer = new(fd);
    endfunction


    task setup();
        svunit_ut.setup();
    endtask


    task teardown();
        svunit_ut.teardown();
    endtask


    `SVUNIT_TESTS_BEGIN

        `SVTEST(dummy)
            `FAIL_IF(0)
        `SVTEST_END

    `SVUNIT_TESTS_END

endmodule
