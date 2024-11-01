/*
 * Copyright 2024 Tudor Timisescu (verificationgentleman.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/**
 * Maps dictionaries (i.e. associative arrays) onto output rows.
 */
class dict_writer;
    local const bit[31:0] fd;
    local const string field_names[];

    /**
     * Creates a new {@link dict_writer}.
     *
     * @param fd file descriptor pointing to the output file
     * @param field_names list of keys that identify the order in which values in the dictionary
     *              passed to the {@link write_row} method are written to file
     */
    function new(bit[31:0] fd, string field_names[]);
        // TODO Check that this is a legal file descriptor (e.g not an MCD)
        this.fd = fd;

        // TODO Check that this is a legal array (e.g not empty, no duplicates)
        this.field_names = field_names;
    endfunction


    /**
     * Writes a row with the field names (as specified in the constructor) to the writer’s file
     * descriptor.
     */
    function void write_header();
        $fwrite(fd, field_names[0]);
        for (int i = 1; i < field_names.size(); i++)
            $fwrite(fd, ",%s", field_names[i]);
        $fwrite(fd, "\n");
    endfunction


    /**
     * Writes the row argument to the writer’s file descriptor
     *
     * @param row dictionary containing values for the field names
     */
    function void write_row(string row[string]);
        // TODO Check that row is legal (e.g. not empty)
        $fwrite(fd, row[field_names[0]]);
        for (int i = 1; i < field_names.size(); i++)
            $fwrite(fd, ",%s", row[field_names[i]]);
        $fwrite(fd, "\n");
    endfunction
endclass
