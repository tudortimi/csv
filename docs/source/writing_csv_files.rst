Writing CSV Files
=================

Open a file descriptor for the output file:

.. literalinclude:: ../../examples/dict-writer/src/main/sv/dict_writer_example.sv
   :language: systemverilog
   :lines: 5
   :dedent:

Create a `dict_writer`,
passing it the file descriptor
and a list of field names:

.. literalinclude:: ../../examples/dict-writer/src/main/sv/dict_writer_example.sv
   :language: systemverilog
   :lines: 6
   :dedent:

Write the header of the CSV file:

.. literalinclude:: ../../examples/dict-writer/src/main/sv/dict_writer_example.sv
   :language: systemverilog
   :lines: 7
   :dedent:

Write a row:

.. literalinclude:: ../../examples/dict-writer/src/main/sv/dict_writer_example.sv
   :language: systemverilog
   :lines: 8
   :dedent:

Writing values containing spaces or quotes is also supported:

.. literalinclude:: ../../examples/dict-writer/src/main/sv/dict_writer_example.sv
   :language: systemverilog
   :lines: 9
   :dedent:

Close the output file:

.. literalinclude:: ../../examples/dict-writer/src/main/sv/dict_writer_example.sv
   :language: systemverilog
   :lines: 10
   :dedent:
