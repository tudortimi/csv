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

    /**
     * Creates a new {@link dict_writer}.
     *
     * @param fd file descriptor pointing to the output file
     */
    function new(bit[31:0] fd);
        // TODO Check that this is a legal file descriptor (e.g not an MCD)
        this.fd = fd;
    endfunction
endclass
