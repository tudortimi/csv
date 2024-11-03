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
            bit[31:0] expected_fd = $fopen("expected.csv");

            fd = $fopen("file.csv", "w");
            writer = new(fd, '{ "some_field" });
            writer.write_header();
            $fclose(fd);

            $fdisplay(expected_fd, "some_field");
            $fclose(expected_fd);
            check_contents_identical("expected.csv", "file.csv");
        `SVTEST_END


        `SVTEST(can_write_multiple_fields_to_header_row)
            bit[31:0] expected_fd = $fopen("expected.csv");

            fd = $fopen("file.csv", "w");
            writer = new(fd, '{ "field0", "field1", "field2" });
            writer.write_header();
            $fclose(fd);

            $fdisplay(expected_fd, "field0,field1,field2");
            $fclose(expected_fd);
            check_contents_identical("expected.csv", "file.csv");
        `SVTEST_END


        `SVTEST(can_write_single_value_to_row)
            bit[31:0] expected_fd = $fopen("expected.csv");

            fd = $fopen("file.csv", "w");
            writer = new(fd, '{ "some_field" });
            writer.write_row('{ "some_field": "some_value" });
            $fclose(fd);

            $fdisplay(expected_fd, "some_value");
            $fclose(expected_fd);
            check_contents_identical("expected.csv", "file.csv");
        `SVTEST_END


        `SVTEST(can_write_multiple_fields_to_row)
            bit[31:0] expected_fd = $fopen("expected.csv");

            fd = $fopen("file.csv", "w");
            writer = new(fd, '{ "field0", "field1", "field2" });
            writer.write_row('{ "field0": "value0", "field1": "value1", "field2": "value2" });
            $fclose(fd);

            $fdisplay(expected_fd, "value0,value1,value2");
            $fclose(expected_fd);
            check_contents_identical("expected.csv", "file.csv");
        `SVTEST_END


        `SVTEST(can_write_single_value_with_space_to_row)
            bit[31:0] expected_fd = $fopen("expected.csv");

            fd = $fopen("file.csv", "w");
            writer = new(fd, '{ "some_field" });
            writer.write_row('{ "some_field": "some value" });
            $fclose(fd);

            $fdisplay(expected_fd, "\"some value\"");
            $fclose(expected_fd);
            check_contents_identical("expected.csv", "file.csv");
        `SVTEST_END


        `SVTEST(can_write_subsequent_value_with_space_to_row)
            bit[31:0] expected_fd = $fopen("expected.csv");

            fd = $fopen("file.csv", "w");
            writer = new(fd, '{ "some_field", "some_other_field"});
            writer.write_row('{ "some_field": "some_value", "some_other_field": "some other value" });
            $fclose(fd);

            $fdisplay(expected_fd, "some_value,\"some other value\"");
            $fclose(expected_fd);
            check_contents_identical("expected.csv", "file.csv");
        `SVTEST_END

    `SVUNIT_TESTS_END


    task automatic check_contents_identical(string expected_file_path, string actual_file_path);
        bit[31:0] expected_fd = $fopen(expected_file_path, "r");
        bit[31:0] actual_fd = $fopen(actual_file_path, "r");

        while (!$feof(expected_fd)) begin
            string expected_line;
            string actual_line;
            $fgets(expected_line, expected_fd);
            $fgets(actual_line, actual_fd);
            `FAIL_UNLESS_STR_EQUAL(expected_line, actual_line)
        end

        $fclose(expected_fd);
        $fclose(actual_fd);
    endtask

endmodule
