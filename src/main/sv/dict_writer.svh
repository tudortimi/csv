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
    local static const string DOUBLE_QUOTE = "\"";

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
        write_list(field_names);
    endfunction


    local function void write_list(string list[]);
        $fwrite(fd, get_value_to_write(list[0]));
        for (int i = 1; i < list.size(); i++)
            $fwrite(fd, ",%s", get_value_to_write(list[i]));
        $fwrite(fd, "\n");
    endfunction


    local function string get_value_to_write(string value);
        if (contains_double_quote(value))
            return { DOUBLE_QUOTE, with_escaped_double_quotes(value), DOUBLE_QUOTE };
        return value;
    endfunction


    local function bit contains_double_quote(string s);
        foreach (s[i]) begin
            if (s[i] == DOUBLE_QUOTE[0])
                return 1;
        end
        return 0;
    endfunction


    local function string with_escaped_double_quotes(string s);
        string result;
        foreach (s[i]) begin
            if (s[i] == DOUBLE_QUOTE[0])
                result = { result, DOUBLE_QUOTE, DOUBLE_QUOTE };
            else
                result = { result, s[i] };
        end
        return result;
    endfunction


    /**
     * Writes the row argument to the writer’s file descriptor
     *
     * @param row dictionary containing values for the field names
     */
    function void write_row(string row[string]);
        // TODO Check that row is legal (e.g. not empty)
        string field_values[] = new[field_names.size()];
        foreach (field_names[i])
            field_values[i] = row[field_names[i]];
        write_list(field_values);
    endfunction
endclass
