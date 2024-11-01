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
    endfunction


    task setup();
        svunit_ut.setup();
    endtask


    task teardown();
        svunit_ut.teardown();
    endtask


    `SVUNIT_TESTS_BEGIN

        `SVTEST(can_write_single_field_to_header_row)
            string line;

            fd = $fopen("file.csv", "w");
            writer = new(fd, '{ "some_field" });
            writer.write_header();
            $fclose(fd);

            fd = $fopen("file.csv", "r");
            $fgets(line, fd);
            `FAIL_IF_LOG(line.len() == 0 && $feof(fd), "File is empty")
            `FAIL_UNLESS_STR_EQUAL(line, "some_field\n")

            $fgets(line, fd);
            `FAIL_UNLESS(line.len() == 0)
            `FAIL_UNLESS_LOG($feof(fd), "File contains more lines")
            $fclose(fd);
        `SVTEST_END


        `SVTEST(can_write_multiple_fields_to_header_row)
            string line;

            fd = $fopen("file.csv", "w");
            writer = new(fd, '{ "field0", "field1", "field2" });
            writer.write_header();
            $fclose(fd);

            fd = $fopen("file.csv", "r");
            $fgets(line, fd);
            `FAIL_IF_LOG(line.len() == 0 && $feof(fd), "File is empty")
            `FAIL_UNLESS_STR_EQUAL(line, "field0,field1,field2\n")

            $fgets(line, fd);
            `FAIL_UNLESS(line.len() == 0)
            `FAIL_UNLESS_LOG($feof(fd), "File contains more lines")
            $fclose(fd);
        `SVTEST_END

    `SVUNIT_TESTS_END

endmodule
