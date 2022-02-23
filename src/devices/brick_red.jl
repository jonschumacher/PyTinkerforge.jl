


export BrickREDCreateSession
struct BrickREDCreateSession
    error_code::Integer
    session_id::Integer
end

export BrickREDAllocateString
struct BrickREDAllocateString
    error_code::Integer
    string_id::Integer
end

export BrickREDStringLength
struct BrickREDStringLength
    error_code::Integer
    length::Integer
end

export BrickREDStringChunk
struct BrickREDStringChunk
    error_code::Integer
    buffer::String
end

export BrickREDAllocateList
struct BrickREDAllocateList
    error_code::Integer
    list_id::Integer
end

export BrickREDListLength
struct BrickREDListLength
    error_code::Integer
    length::Integer
end

export BrickREDListItem
struct BrickREDListItem
    error_code::Integer
    item_object_id::Integer
    type::Integer
end

export BrickREDOpenFile
struct BrickREDOpenFile
    error_code::Integer
    file_id::Integer
end

export BrickREDCreatePipe
struct BrickREDCreatePipe
    error_code::Integer
    file_id::Integer
end

export BrickREDFileInfo
struct BrickREDFileInfo
    error_code::Integer
    type::Integer
    name_string_id::Integer
    flags::Integer
    permissions::Integer
    uid::Integer
    gid::Integer
    length::Integer
    access_timestamp::Integer
    modification_timestamp::Integer
    status_change_timestamp::Integer
end

export BrickREDReadFile
struct BrickREDReadFile
    error_code::Integer
    buffer::Vector{Integer}
    length_read::Integer
end

export BrickREDWriteFile
struct BrickREDWriteFile
    error_code::Integer
    length_written::Integer
end

export BrickREDSetFilePosition
struct BrickREDSetFilePosition
    error_code::Integer
    position::Integer
end

export BrickREDFilePosition
struct BrickREDFilePosition
    error_code::Integer
    position::Integer
end

export BrickREDFileEvents
struct BrickREDFileEvents
    error_code::Integer
    events::Integer
end

export BrickREDOpenDirectory
struct BrickREDOpenDirectory
    error_code::Integer
    directory_id::Integer
end

export BrickREDDirectoryName
struct BrickREDDirectoryName
    error_code::Integer
    name_string_id::Integer
end

export BrickREDNextDirectoryEntry
struct BrickREDNextDirectoryEntry
    error_code::Integer
    name_string_id::Integer
    type::Integer
end

export BrickREDProcesses
struct BrickREDProcesses
    error_code::Integer
    processes_list_id::Integer
end

export BrickREDSpawnProcess
struct BrickREDSpawnProcess
    error_code::Integer
    process_id::Integer
end

export BrickREDProcessCommand
struct BrickREDProcessCommand
    error_code::Integer
    executable_string_id::Integer
    arguments_list_id::Integer
    environment_list_id::Integer
    working_directory_string_id::Integer
end

export BrickREDProcessIdentity
struct BrickREDProcessIdentity
    error_code::Integer
    pid::Integer
    uid::Integer
    gid::Integer
end

export BrickREDProcessStdio
struct BrickREDProcessStdio
    error_code::Integer
    stdin_file_id::Integer
    stdout_file_id::Integer
    stderr_file_id::Integer
end

export BrickREDProcessState
struct BrickREDProcessState
    error_code::Integer
    state::Integer
    timestamp::Integer
    exit_code::Integer
end

export BrickREDPrograms
struct BrickREDPrograms
    error_code::Integer
    programs_list_id::Integer
end

export BrickREDDefineProgram
struct BrickREDDefineProgram
    error_code::Integer
    program_id::Integer
end

export BrickREDProgramIdentifier
struct BrickREDProgramIdentifier
    error_code::Integer
    identifier_string_id::Integer
end

export BrickREDProgramRootDirectory
struct BrickREDProgramRootDirectory
    error_code::Integer
    root_directory_string_id::Integer
end

export BrickREDProgramCommand
struct BrickREDProgramCommand
    error_code::Integer
    executable_string_id::Integer
    arguments_list_id::Integer
    environment_list_id::Integer
    working_directory_string_id::Integer
end

export BrickREDProgramStdioRedirection
struct BrickREDProgramStdioRedirection
    error_code::Integer
    stdin_redirection::Integer
    stdin_file_name_string_id::Integer
    stdout_redirection::Integer
    stdout_file_name_string_id::Integer
    stderr_redirection::Integer
    stderr_file_name_string_id::Integer
end

export BrickREDProgramSchedule
struct BrickREDProgramSchedule
    error_code::Integer
    start_mode::Integer
    continue_after_error::Bool
    start_interval::Integer
    start_fields_string_id::Integer
end

export BrickREDProgramSchedulerState
struct BrickREDProgramSchedulerState
    error_code::Integer
    state::Integer
    timestamp::Integer
    message_string_id::Integer
end

export BrickREDLastSpawnedProgramProcess
struct BrickREDLastSpawnedProgramProcess
    error_code::Integer
    process_id::Integer
    timestamp::Integer
end

export BrickREDCustomProgramOptionNames
struct BrickREDCustomProgramOptionNames
    error_code::Integer
    names_list_id::Integer
end

export BrickREDCustomProgramOptionValue
struct BrickREDCustomProgramOptionValue
    error_code::Integer
    value_string_id::Integer
end

export BrickREDIdentity
struct BrickREDIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickRED
"""
Executes user programs and controls other Bricks/Bricklets standalone
"""
mutable struct BrickRED <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickRED(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.brick_red")
        deviceInternal = package.BrickRED(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export create_session
"""
    $(SIGNATURES)


"""
function create_session(device::BrickRED, lifetime)
    return device.deviceInternal.create_session(lifetime)
end

export expire_session
"""
    $(SIGNATURES)


"""
function expire_session(device::BrickRED, session_id)
    return device.deviceInternal.expire_session(session_id)
end

export expire_session_unchecked
"""
    $(SIGNATURES)


"""
function expire_session_unchecked(device::BrickRED, session_id)
    device.deviceInternal.expire_session_unchecked(session_id)
end

export keep_session_alive
"""
    $(SIGNATURES)


"""
function keep_session_alive(device::BrickRED, session_id, lifetime)
    return device.deviceInternal.keep_session_alive(session_id, lifetime)
end

export release_object
"""
    $(SIGNATURES)

Decreases the reference count of an object by one and returns the resulting
error code. If the reference count reaches zero the object gets destroyed.
"""
function release_object(device::BrickRED, object_id, session_id)
    return device.deviceInternal.release_object(object_id, session_id)
end

export release_object_unchecked
"""
    $(SIGNATURES)


"""
function release_object_unchecked(device::BrickRED, object_id, session_id)
    device.deviceInternal.release_object_unchecked(object_id, session_id)
end

export allocate_string
"""
    $(SIGNATURES)

Allocates a new string object, reserves ``length_to_reserve`` bytes memory
for it and sets up to the first 60 bytes. Set ``length_to_reserve`` to the
length of the string that should be stored in the string object.

Returns the object ID of the new string object and the resulting error code.
"""
function allocate_string(device::BrickRED, length_to_reserve, buffer, session_id)
    return device.deviceInternal.allocate_string(length_to_reserve, buffer, session_id)
end

export truncate_string
"""
    $(SIGNATURES)

Truncates a string object to ``length`` bytes and returns the resulting
error code.
"""
function truncate_string(device::BrickRED, string_id, length)
    return device.deviceInternal.truncate_string(string_id, length)
end

export get_string_length
"""
    $(SIGNATURES)

Returns the length of a string object and the resulting error code.
"""
function get_string_length(device::BrickRED, string_id)
    return device.deviceInternal.get_string_length(string_id)
end

export set_string_chunk
"""
    $(SIGNATURES)

Sets a chunk of up to 58 bytes in a string object beginning at ``offset``.

Returns the resulting error code.
"""
function set_string_chunk(device::BrickRED, string_id, offset, buffer)
    return device.deviceInternal.set_string_chunk(string_id, offset, buffer)
end

export get_string_chunk
"""
    $(SIGNATURES)

Returns a chunk up to 63 bytes from a string object beginning at ``offset`` and
returns the resulting error code.
"""
function get_string_chunk(device::BrickRED, string_id, offset)
    return device.deviceInternal.get_string_chunk(string_id, offset)
end

export allocate_list
"""
    $(SIGNATURES)

Allocates a new list object and reserves memory for ``length_to_reserve``
items. Set ``length_to_reserve`` to the number of items that should be stored
in the list object.

Returns the object ID of the new list object and the resulting error code.

When a list object gets destroyed then the reference count of each object in
the list object is decreased by one.
"""
function allocate_list(device::BrickRED, length_to_reserve, session_id)
    return device.deviceInternal.allocate_list(length_to_reserve, session_id)
end

export get_list_length
"""
    $(SIGNATURES)

Returns the length of a list object in items and the resulting error code.
"""
function get_list_length(device::BrickRED, list_id)
    return device.deviceInternal.get_list_length(list_id)
end

export get_list_item
"""
    $(SIGNATURES)

Returns the object ID and type of the object stored at ``index`` in a list
object and returns the resulting error code.

Possible object types are:

* String = 0
* List = 1
* File = 2
* Directory = 3
* Process = 4
* Program = 5
"""
function get_list_item(device::BrickRED, list_id, index, session_id)
    return device.deviceInternal.get_list_item(list_id, index, session_id)
end

export append_to_list
"""
    $(SIGNATURES)

Appends an object to a list object and increases the reference count of the
appended object by one.

Returns the resulting error code.
"""
function append_to_list(device::BrickRED, list_id, item_object_id)
    return device.deviceInternal.append_to_list(list_id, item_object_id)
end

export remove_from_list
"""
    $(SIGNATURES)

Removes the object stored at ``index`` from a list object and decreases the
reference count of the removed object by one.

Returns the resulting error code.
"""
function remove_from_list(device::BrickRED, list_id, index)
    return device.deviceInternal.remove_from_list(list_id, index)
end

export open_file
"""
    $(SIGNATURES)

Opens an existing file or creates a new file and allocates a new file object
for it.

FIXME: name has to be absolute

The reference count of the name string object is increased by one. When the
file object gets destroyed then the reference count of the name string object is
decreased by one. Also the name string object is locked and cannot be modified
while the file object holds a reference to it.

The ``flags`` parameter takes a ORed combination of the following possible file
flags (in hexadecimal notation):

* ReadOnly = 0x0001 (O_RDONLY)
* WriteOnly = 0x0002 (O_WRONLY)
* ReadWrite = 0x0004 (O_RDWR)
* Append = 0x0008 (O_APPEND)
* Create = 0x0010 (O_CREAT)
* Exclusive = 0x0020 (O_EXCL)
* NonBlocking = 0x0040 (O_NONBLOCK)
* Truncate = 0x0080 (O_TRUNC)
* Temporary = 0x0100
* Replace = 0x0200

FIXME: explain *Temporary* and *Replace* flag

The ``permissions`` parameter takes a ORed combination of the following
possible file permissions (in octal notation) that match the common UNIX
permission bits:

* UserRead = 00400
* UserWrite = 00200
* UserExecute = 00100
* GroupRead = 00040
* GroupWrite = 00020
* GroupExecute = 00010
* OthersRead = 00004
* OthersWrite = 00002
* OthersExecute = 00001

Returns the object ID of the new file object and the resulting error code.
"""
function open_file(device::BrickRED, name_string_id, flags, permissions, uid, gid, session_id)
    return device.deviceInternal.open_file(name_string_id, flags, permissions, uid, gid, session_id)
end

export create_pipe
"""
    $(SIGNATURES)

Creates a new pipe and allocates a new file object for it.

The ``flags`` parameter takes a ORed combination of the following possible
pipe flags (in hexadecimal notation):

* NonBlockingRead = 0x0001
* NonBlockingWrite = 0x0002

The length of the pipe buffer can be specified with the ``length`` parameter
in bytes. If length is set to zero, then the default pipe buffer length is used.

Returns the object ID of the new file object and the resulting error code.
"""
function create_pipe(device::BrickRED, flags, length, session_id)
    return device.deviceInternal.create_pipe(flags, length, session_id)
end

export get_file_info
"""
    $(SIGNATURES)

Returns various information about a file and the resulting error code.

Possible file types are:

* Unknown = 0
* Regular = 1
* Directory = 2
* Character = 3
* Block = 4
* FIFO = 5
* Symlink = 6
* Socket = 7
* Pipe = 8

If the file type is *Pipe* then the returned name string object is invalid,
because a pipe has no name. Otherwise the returned name string object was used
to open or create the file object, as passed to :func:`Open File`.

The returned flags were used to open or create the file object, as passed to
:func:`Open File` or :func:`Create Pipe`. See the respective function for a list
of possible file and pipe flags.

FIXME: everything except flags and length is invalid if file type is *Pipe*
"""
function get_file_info(device::BrickRED, file_id, session_id)
    return device.deviceInternal.get_file_info(file_id, session_id)
end

export read_file
"""
    $(SIGNATURES)

Reads up to 62 bytes from a file object.

Returns the bytes read, the actual number of bytes read and the resulting
error code.

If there is not data to be read, either because the file position reached
end-of-file or because there is not data in the pipe, then zero bytes are
returned.

If the file object was created by :func:`Open File` without the *NonBlocking*
flag or by :func:`Create Pipe` without the *NonBlockingRead* flag then the
error code *NotSupported* is returned.
"""
function read_file(device::BrickRED, file_id, length_to_read)
    return device.deviceInternal.read_file(file_id, length_to_read)
end

export read_file_async
"""
    $(SIGNATURES)

Reads up to 2\\ :sup:`63`\\  - 1 bytes from a file object asynchronously.

Reports the bytes read (in 60 byte chunks), the actual number of bytes read and
the resulting error code via the :cb:`Async File Read` callback.

If there is not data to be read, either because the file position reached
end-of-file or because there is not data in the pipe, then zero bytes are
reported.

If the file object was created by :func:`Open File` without the *NonBlocking*
flag or by :func:`Create Pipe` without the *NonBlockingRead* flag then the error
code *NotSupported* is reported via the :cb:`Async File Read` callback.
"""
function read_file_async(device::BrickRED, file_id, length_to_read)
    device.deviceInternal.read_file_async(file_id, length_to_read)
end

export abort_async_file_read
"""
    $(SIGNATURES)

Aborts a :func:`Read File Async` operation in progress.

Returns the resulting error code.

On success the :cb:`Async File Read` callback will report *OperationAborted*.
"""
function abort_async_file_read(device::BrickRED, file_id)
    return device.deviceInternal.abort_async_file_read(file_id)
end

export write_file
"""
    $(SIGNATURES)

Writes up to 61 bytes to a file object.

Returns the actual number of bytes written and the resulting error code.

If the file object was created by :func:`Open File` without the *NonBlocking*
flag or by :func:`Create Pipe` without the *NonBlockingWrite* flag then the
error code *NotSupported* is returned.
"""
function write_file(device::BrickRED, file_id, buffer, length_to_write)
    return device.deviceInternal.write_file(file_id, buffer, length_to_write)
end

export write_file_unchecked
"""
    $(SIGNATURES)

Writes up to 61 bytes to a file object.

Does neither report the actual number of bytes written nor the resulting error
code.

If the file object was created by :func:`Open File` without the *NonBlocking*
flag or by :func:`Create Pipe` without the *NonBlockingWrite* flag then the
write operation will fail silently.
"""
function write_file_unchecked(device::BrickRED, file_id, buffer, length_to_write)
    device.deviceInternal.write_file_unchecked(file_id, buffer, length_to_write)
end

export write_file_async
"""
    $(SIGNATURES)

Writes up to 61 bytes to a file object.

Reports the actual number of bytes written and the resulting error code via the
:cb:`Async File Write` callback.

If the file object was created by :func:`Open File` without the *NonBlocking*
flag or by :func:`Create Pipe` without the *NonBlockingWrite* flag then the
error code *NotSupported* is reported via the :cb:`Async File Write` callback.
"""
function write_file_async(device::BrickRED, file_id, buffer, length_to_write)
    device.deviceInternal.write_file_async(file_id, buffer, length_to_write)
end

export set_file_position
"""
    $(SIGNATURES)

Set the current seek position of a file object relative to ``origin``.

Possible file origins are:

* Beginning = 0
* Current = 1
* End = 2

Returns the resulting absolute seek position and error code.

If the file object was created by :func:`Create Pipe` then it has no seek
position and the error code *InvalidSeek* is returned.
"""
function set_file_position(device::BrickRED, file_id, offset, origin)
    return device.deviceInternal.set_file_position(file_id, offset, origin)
end

export get_file_position
"""
    $(SIGNATURES)

Returns the current seek position of a file object and returns the
resulting error code.

If the file object was created by :func:`Create Pipe` then it has no seek
position and the error code *InvalidSeek* is returned.
"""
function get_file_position(device::BrickRED, file_id)
    return device.deviceInternal.get_file_position(file_id)
end

export set_file_events
"""
    $(SIGNATURES)


"""
function set_file_events(device::BrickRED, file_id, events)
    return device.deviceInternal.set_file_events(file_id, events)
end

export get_file_events
"""
    $(SIGNATURES)


"""
function get_file_events(device::BrickRED, file_id)
    return device.deviceInternal.get_file_events(file_id)
end

export open_directory
"""
    $(SIGNATURES)

Opens an existing directory and allocates a new directory object for it.

FIXME: name has to be absolute

The reference count of the name string object is increased by one. When the
directory object is destroyed then the reference count of the name string
object is decreased by one. Also the name string object is locked and cannot be
modified while the directory object holds a reference to it.

Returns the object ID of the new directory object and the resulting error code.
"""
function open_directory(device::BrickRED, name_string_id, session_id)
    return device.deviceInternal.open_directory(name_string_id, session_id)
end

export get_directory_name
"""
    $(SIGNATURES)

Returns the name of a directory object, as passed to :func:`Open Directory`, and
the resulting error code.
"""
function get_directory_name(device::BrickRED, directory_id, session_id)
    return device.deviceInternal.get_directory_name(directory_id, session_id)
end

export get_next_directory_entry
"""
    $(SIGNATURES)

Returns the next entry in a directory object and the resulting error code.

If there is not next entry then error code *NoMoreData* is returned. To rewind
a directory object call :func:`Rewind Directory`.

Possible directory entry types are:

* Unknown = 0
* Regular = 1
* Directory = 2
* Character = 3
* Block = 4
* FIFO = 5
* Symlink = 6
* Socket = 7
"""
function get_next_directory_entry(device::BrickRED, directory_id, session_id)
    return device.deviceInternal.get_next_directory_entry(directory_id, session_id)
end

export rewind_directory
"""
    $(SIGNATURES)

Rewinds a directory object and returns the resulting error code.
"""
function rewind_directory(device::BrickRED, directory_id)
    return device.deviceInternal.rewind_directory(directory_id)
end

export create_directory
"""
    $(SIGNATURES)

FIXME: name has to be absolute
"""
function create_directory(device::BrickRED, name_string_id, flags, permissions, uid, gid)
    return device.deviceInternal.create_directory(name_string_id, flags, permissions, uid, gid)
end

export get_processes
"""
    $(SIGNATURES)


"""
function get_processes(device::BrickRED, session_id)
    return device.deviceInternal.get_processes(session_id)
end

export spawn_process
"""
    $(SIGNATURES)


"""
function spawn_process(device::BrickRED, executable_string_id, arguments_list_id, environment_list_id, working_directory_string_id, uid, gid, stdin_file_id, stdout_file_id, stderr_file_id, session_id)
    return device.deviceInternal.spawn_process(executable_string_id, arguments_list_id, environment_list_id, working_directory_string_id, uid, gid, stdin_file_id, stdout_file_id, stderr_file_id, session_id)
end

export kill_process
"""
    $(SIGNATURES)

Sends a UNIX signal to a process object and returns the resulting error code.

Possible UNIX signals are:

* Interrupt = 2
* Quit = 3
* Abort = 6
* Kill = 9
* User1 = 10
* User2 = 12
* Terminate = 15
* Continue =  18
* Stop = 19
"""
function kill_process(device::BrickRED, process_id, signal)
    return device.deviceInternal.kill_process(process_id, signal)
end

export get_process_command
"""
    $(SIGNATURES)

Returns the executable, arguments, environment and working directory used to
spawn a process object, as passed to :func:`Spawn Process`, and the resulting
error code.
"""
function get_process_command(device::BrickRED, process_id, session_id)
    return device.deviceInternal.get_process_command(process_id, session_id)
end

export get_process_identity
"""
    $(SIGNATURES)

Returns the process ID and the user and group ID used to spawn a process object,
as passed to :func:`Spawn Process`, and the resulting error code.

The process ID is only valid if the state is *Running* or *Stopped*, see
:func:`Get Process State`.
"""
function get_process_identity(device::BrickRED, process_id)
    return device.deviceInternal.get_process_identity(process_id)
end

export get_process_stdio
"""
    $(SIGNATURES)

Returns the stdin, stdout and stderr files used to spawn a process object, as
passed to :func:`Spawn Process`, and the resulting error code.
"""
function get_process_stdio(device::BrickRED, process_id, session_id)
    return device.deviceInternal.get_process_stdio(process_id, session_id)
end

export get_process_state
"""
    $(SIGNATURES)

Returns the current state, timestamp and exit code of a process object, and
the resulting error code.

Possible process states are:

* Unknown = 0
* Running = 1
* Error = 2
* Exited = 3
* Killed = 4
* Stopped = 5

The timestamp represents the UNIX time since when the process is in its current
state.

The exit code is only valid if the state is *Error*, *Exited*, *Killed* or
*Stopped* and has different meanings depending on the state:

* Error: error code for error occurred while spawning the process (see below)
* Exited: exit status of the process
* Killed: UNIX signal number used to kill the process
* Stopped: UNIX signal number used to stop the process

Possible exit/error codes in *Error* state are:

* InternalError = 125
* CannotExecute = 126
* DoesNotExist = 127

The *CannotExecute* error can be caused by the executable being opened for
writing.
"""
function get_process_state(device::BrickRED, process_id)
    return device.deviceInternal.get_process_state(process_id)
end

export get_programs
"""
    $(SIGNATURES)


"""
function get_programs(device::BrickRED, session_id)
    return device.deviceInternal.get_programs(session_id)
end

export define_program
"""
    $(SIGNATURES)


"""
function define_program(device::BrickRED, identifier_string_id, session_id)
    return device.deviceInternal.define_program(identifier_string_id, session_id)
end

export purge_program
"""
    $(SIGNATURES)


"""
function purge_program(device::BrickRED, program_id, cookie)
    return device.deviceInternal.purge_program(program_id, cookie)
end

export get_program_identifier
"""
    $(SIGNATURES)


"""
function get_program_identifier(device::BrickRED, program_id, session_id)
    return device.deviceInternal.get_program_identifier(program_id, session_id)
end

export get_program_root_directory
"""
    $(SIGNATURES)

FIXME: root directory is absolute: <home>/programs/<identifier>
"""
function get_program_root_directory(device::BrickRED, program_id, session_id)
    return device.deviceInternal.get_program_root_directory(program_id, session_id)
end

export set_program_command
"""
    $(SIGNATURES)

FIXME: working directory is relative to <home>/programs/<identifier>/bin
"""
function set_program_command(device::BrickRED, program_id, executable_string_id, arguments_list_id, environment_list_id, working_directory_string_id)
    return device.deviceInternal.set_program_command(program_id, executable_string_id, arguments_list_id, environment_list_id, working_directory_string_id)
end

export get_program_command
"""
    $(SIGNATURES)

FIXME: working directory is relative to <home>/programs/<identifier>/bin
"""
function get_program_command(device::BrickRED, program_id, session_id)
    return device.deviceInternal.get_program_command(program_id, session_id)
end

export set_program_stdio_redirection
"""
    $(SIGNATURES)

FIXME: stdio file names are relative to <home>/programs/<identifier>/bin
"""
function set_program_stdio_redirection(device::BrickRED, program_id, stdin_redirection, stdin_file_name_string_id, stdout_redirection, stdout_file_name_string_id, stderr_redirection, stderr_file_name_string_id)
    return device.deviceInternal.set_program_stdio_redirection(program_id, stdin_redirection, stdin_file_name_string_id, stdout_redirection, stdout_file_name_string_id, stderr_redirection, stderr_file_name_string_id)
end

export get_program_stdio_redirection
"""
    $(SIGNATURES)

FIXME: stdio file names are relative to <home>/programs/<identifier>/bin
"""
function get_program_stdio_redirection(device::BrickRED, program_id, session_id)
    return device.deviceInternal.get_program_stdio_redirection(program_id, session_id)
end

export set_program_schedule
"""
    $(SIGNATURES)


"""
function set_program_schedule(device::BrickRED, program_id, start_mode, continue_after_error, start_interval, start_fields_string_id)
    return device.deviceInternal.set_program_schedule(program_id, start_mode, continue_after_error, start_interval, start_fields_string_id)
end

export get_program_schedule
"""
    $(SIGNATURES)


"""
function get_program_schedule(device::BrickRED, program_id, session_id)
    return device.deviceInternal.get_program_schedule(program_id, session_id)
end

export get_program_scheduler_state
"""
    $(SIGNATURES)

FIXME: message is currently valid in error-occurred state only
"""
function get_program_scheduler_state(device::BrickRED, program_id, session_id)
    return device.deviceInternal.get_program_scheduler_state(program_id, session_id)
end

export continue_program_schedule
"""
    $(SIGNATURES)


"""
function continue_program_schedule(device::BrickRED, program_id)
    return device.deviceInternal.continue_program_schedule(program_id)
end

export start_program
"""
    $(SIGNATURES)


"""
function start_program(device::BrickRED, program_id)
    return device.deviceInternal.start_program(program_id)
end

export get_last_spawned_program_process
"""
    $(SIGNATURES)


"""
function get_last_spawned_program_process(device::BrickRED, program_id, session_id)
    return device.deviceInternal.get_last_spawned_program_process(program_id, session_id)
end

export get_custom_program_option_names
"""
    $(SIGNATURES)


"""
function get_custom_program_option_names(device::BrickRED, program_id, session_id)
    return device.deviceInternal.get_custom_program_option_names(program_id, session_id)
end

export set_custom_program_option_value
"""
    $(SIGNATURES)


"""
function set_custom_program_option_value(device::BrickRED, program_id, name_string_id, value_string_id)
    return device.deviceInternal.set_custom_program_option_value(program_id, name_string_id, value_string_id)
end

export get_custom_program_option_value
"""
    $(SIGNATURES)


"""
function get_custom_program_option_value(device::BrickRED, program_id, name_string_id, session_id)
    return device.deviceInternal.get_custom_program_option_value(program_id, name_string_id, session_id)
end

export remove_custom_program_option
"""
    $(SIGNATURES)


"""
function remove_custom_program_option(device::BrickRED, program_id, name_string_id)
    return device.deviceInternal.remove_custom_program_option(program_id, name_string_id)
end

export get_identity
"""
    $(SIGNATURES)

Returns the UID, the UID where the Brick is connected to,
the position, the hardware and firmware version as well as the
device identifier.

The position is the position in the stack from '0' (bottom) to '8' (top).

The device identifier numbers can be found :ref:`here <device_identifier>`.
|device_identifier_constant|
"""
function get_identity(device::BrickRED)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickRED, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
