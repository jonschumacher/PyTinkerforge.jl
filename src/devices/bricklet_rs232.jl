


export BrickletRS232Read
struct BrickletRS232Read
    message::Vector{Char}
    length::Integer
end

export BrickletRS232Configuration
struct BrickletRS232Configuration
    baudrate::Integer
    parity::Integer
    stopbits::Integer
    wordlength::Integer
    hardware_flowcontrol::Integer
    software_flowcontrol::Integer
end

export BrickletRS232ReadFrame
struct BrickletRS232ReadFrame
    message::Vector{Char}
    length::Integer
end

export BrickletRS232Identity
struct BrickletRS232Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRS232
"""
Communicates with RS232 devices
"""
mutable struct BrickletRS232 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRS232(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_rs232")
        deviceInternal = package.BrickletRS232(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write
"""
    $(SIGNATURES)

Writes a string of up to 60 characters to the RS232 interface. The string
can be binary data, ASCII or similar is not necessary.

The length of the string has to be given as an additional parameter.

The return value is the number of bytes that could be written.

See :func:`Set Configuration` for configuration possibilities
regarding baudrate, parity and so on.
"""
function write(device::BrickletRS232, message, length)
    return device.deviceInternal.write(message, length)
end

export read
"""
    $(SIGNATURES)

Returns the currently buffered message. The maximum length
of message is 60. If the returned length is 0, no new data was available.

Instead of polling with this function, you can also use
callbacks. See :func:`Enable Read Callback` and :cb:`Read` callback.
"""
function read(device::BrickletRS232)
    return device.deviceInternal.read()
end

export enable_read_callback
"""
    $(SIGNATURES)

Enables the :cb:`Read` callback. This will disable the :cb:`Frame Readable` callback.

By default the callback is disabled.
"""
function enable_read_callback(device::BrickletRS232)
    device.deviceInternal.enable_read_callback()
end

export disable_read_callback
"""
    $(SIGNATURES)

Disables the :cb:`Read` callback.

By default the callback is disabled.
"""
function disable_read_callback(device::BrickletRS232)
    device.deviceInternal.disable_read_callback()
end

export is_read_callback_enabled
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Read` callback is enabled,
*false* otherwise.
"""
function is_read_callback_enabled(device::BrickletRS232)
    return device.deviceInternal.is_read_callback_enabled()
end

export set_configuration
"""
    $(SIGNATURES)

Sets the configuration for the RS232 communication.

Hard-/Software flow control can either be on or off but not both simultaneously on.
"""
function set_configuration(device::BrickletRS232, baudrate, parity, stopbits, wordlength, hardware_flowcontrol, software_flowcontrol)
    device.deviceInternal.set_configuration(baudrate, parity, stopbits, wordlength, hardware_flowcontrol, software_flowcontrol)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletRS232)
    return device.deviceInternal.get_configuration()
end

export set_break_condition
"""
    $(SIGNATURES)

Sets a break condition (the TX output is forced to a logic 0 state).
The parameter sets the hold-time of the break condition.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_break_condition(device::BrickletRS232, break_time)
    device.deviceInternal.set_break_condition(break_time)
end

export set_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Configures the :cb:`Frame Readable` callback. The frame size is the number of bytes, that have to be readable to trigger the callback.
A frame size of 0 disables the callback. A frame size greater than 0 enables the callback and disables the :cb:`Read` callback.

By default the callback is disabled.

.. versionadded:: 2.0.4\$nbsp;(Plugin)
"""
function set_frame_readable_callback_configuration(device::BrickletRS232, frame_size)
    device.deviceInternal.set_frame_readable_callback_configuration(frame_size)
end

export get_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Frame Readable Callback Configuration`.

.. versionadded:: 2.0.4\$nbsp;(Plugin)
"""
function get_frame_readable_callback_configuration(device::BrickletRS232)
    return device.deviceInternal.get_frame_readable_callback_configuration()
end

export read_frame
"""
    $(SIGNATURES)

Returns up to one frame of bytes from the read buffer.
The frame size is configured with :func:`Set Frame Readable Callback Configuration`.
If the returned length is 0, no new data was available.

.. versionadded:: 2.0.4\$nbsp;(Plugin)
"""
function read_frame(device::BrickletRS232)
    return device.deviceInternal.read_frame()
end

export get_identity
"""
    $(SIGNATURES)

Returns the UID, the UID where the Bricklet is connected to,
the position, the hardware and firmware version as well as the
device identifier.

The position can be 'a', 'b', 'c', 'd', 'e', 'f', 'g' or 'h' (Bricklet Port).
A Bricklet connected to an :ref:`Isolator Bricklet <isolator_bricklet>` is always at
position 'z'.

The device identifier numbers can be found :ref:`here <device_identifier>`.
|device_identifier_constant|
"""
function get_identity(device::BrickletRS232)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRS232, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
