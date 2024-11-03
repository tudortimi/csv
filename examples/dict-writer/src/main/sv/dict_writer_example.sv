module automatic dict_writer_example;
    import csv::*;

    initial begin
        bit[31:0] fd = $fopen("output.csv");
        dict_writer writer = new(fd, '{ "field0", "field1" });
        writer.write_header();
        writer.write_row('{ "field0": "word", "field1": "compound-word" });
        writer.write_row('{ "field0": "words separate by space", "field1": "word with \"quotes\"" });
        $fclose(fd);
    end
endmodule
