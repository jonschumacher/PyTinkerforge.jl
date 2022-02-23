


export BrickletRS232V2ReadLowLevel
struct BrickletRS232V2ReadLowLevel
    message_length::Integer
    message_chunk_offset::Integer
    message_chunk_data::Vector{Char}
end

export BrickletRS232V2Configuration
struct BrickletRS232V2Configuration
    baudrate::Integer
    parity::Integer
    stopbits::Integer
    wordlength::Integer
    flowcontrol::Integer
end

export BrickletRS232V2BufferConfig
struct BrickletRS232V2BufferConfig
    send_buffer_size::Integer
    receive_buffer_size::Integer
end

export BrickletRS232V2BufferStatus
struct BrickletRS232V2BufferStatus
    send_buffer_used::Integer
    receive_buffer_used::Integer
end

export BrickletRS232V2ErrorCount
struct BrickletRS232V2ErrorCount
    error_count_overrun::Integer
    error_count_parity::Integer
end

export BrickletRS232V2SPITFPErrorCount
struct BrickletRS232V2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletRS232V2Identity
struct BrickletRS232V2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRS232V2
"""
Communicates with RS232 devices
"""
mutable struct BrickletRS232V2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRS232V2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_rs232_v2")
        deviceInternal = package.BrickletRS232V2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write_low_level
"""
    $(SIGNATURES)

Writes characters to the RS232 interface. The characters can be binary data,
ASCII or similar is not necessary.

The return value is the number of characters that were written.

See :func:`Set Configuration` for configuration possibilities
regarding baud rate, parity and so on.
"""
function write_low_level(device::BrickletRS232V2, message_length, message_chunk_offset, message_chunk_data)
    return device.deviceInternal.write_low_level(message_length, message_chunk_offset, message_chunk_data)
end

export read_low_level
"""
    $(SIGNATURES)

Returns up to *length* characters from receive buffer.

Instead of polling with this function, you can also use
callbacks. But note that this function will return available
data only when the read callback is disabled.
See :func:`Enable Read Callback` and :cb:`Read` callback.
"""
function read_low_level(device::BrickletRS232V2, length)
    return device.deviceInternal.read_low_level(length)
end

export enable_read_callback
"""
    $(SIGNATURES)

Enables the :cb:`Read` callback. This will disable the :cb:`Frame Readable` callback.

By default the callback is disabled.
"""
function enable_read_callback(device::BrickletRS232V2)
    device.deviceInternal.enable_read_callback()
end

export disable_read_callback
"""
    $(SIGNATURES)

Disables the :cb:`Read` callback.

By default the callback is disabled.
"""
function disable_read_callback(device::BrickletRS232V2)
    device.deviceInternal.disable_read_callback()
end

export is_read_callback_enabled
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Read` callback is enabled,
*false* otherwise.
"""
function is_read_callback_enabled(device::BrickletRS232V2)
    return device.deviceInternal.is_read_callback_enabled()
end

export set_configuration
"""
    $(SIGNATURES)

Sets the configuration for the RS232 communication.
"""
function set_configuration(device::BrickletRS232V2, baudrate, parity, stopbits, wordlength, flowcontrol)
    device.deviceInternal.set_configuration(baudrate, parity, stopbits, wordlength, flowcontrol)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletRS232V2)
    return device.deviceInternal.get_configuration()
end

export set_buffer_config
"""
    $(SIGNATURES)

Sets the send and receive buffer size in byte. In total the buffers have to be
10240 byte (10KiB) in size, the minimum buffer size is 1024 byte (1KiB) for each.

The current buffer content is lost if this function is called.

The send buffer holds data that is given by :func:`Write` and
can not be written yet. The receive buffer holds data that is
received through RS232 but could not yet be send to the
user, either by :func:`Read` or through :cb:`Read` callback.
"""
function set_buffer_config(device::BrickletRS232V2, send_buffer_size, receive_buffer_size)
    device.deviceInternal.set_buffer_config(send_buffer_size, receive_buffer_size)
end

export get_buffer_config
"""
    $(SIGNATURES)

Returns the buffer configuration as set by :func:`Set Buffer Config`.
"""
function get_buffer_config(device::BrickletRS232V2)
    return device.deviceInternal.get_buffer_config()
end

export get_buffer_status
"""
    $(SIGNATURES)

Returns the currently used bytes for the send and received buffer.

See :func:`Set Buffer Config` for buffer size configuration.
"""
function get_buffer_status(device::BrickletRS232V2)
    return device.deviceInternal.get_buffer_status()
end

export get_error_count
"""
    $(SIGNATURES)

Returns the current number of overrun and parity errors.
"""
function get_error_count(device::BrickletRS232V2)
    return device.deviceInternal.get_error_count()
end

export set_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Configures the :cb:`Frame Readable` callback. The frame size is the number of bytes, that have to be readable to trigger the callback.
A frame size of 0 disables the callback. A frame size greater than 0 enables the callback and disables the :cb:`Read` callback.

By default the callback is disabled.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_frame_readable_callback_configuration(device::BrickletRS232V2, frame_size)
    device.deviceInternal.set_frame_readable_callback_configuration(frame_size)
end

export get_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Frame Readable Callback Configuration`.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_frame_readable_callback_configuration(device::BrickletRS232V2)
    return device.deviceInternal.get_frame_readable_callback_configuration()
end

export get_spitfp_error_count
"""
    $(SIGNATURES)

Returns the error count for the communication between Brick and Bricklet.

The errors are divided into

* ACK checksum errors,
* message checksum errors,
* framing errors and
* overflow errors.

The errors counts are for errors that occur on the Bricklet side. All
Bricks have a similar function that returns the errors on the Brick side.
"""
function get_spitfp_error_count(device::BrickletRS232V2)
    return device.deviceInternal.get_spitfp_error_count()
end

export set_bootloader_mode
"""
    $(SIGNATURES)

Sets the bootloader mode and returns the status after the requested
mode change was instigated.

You can change from bootloader mode to firmware mode and vice versa. A change
from bootloader mode to firmware mode will only take place if the entry function,
device identifier and CRC are present and correct.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_bootloader_mode(device::BrickletRS232V2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletRS232V2)
    return device.deviceInternal.get_bootloader_mode()
end

export set_write_firmware_pointer
"""
    $(SIGNATURES)

Sets the firmware pointer for :func:`Write Firmware`. The pointer has
to be increased by chunks of size 64. The data is written to flash
every 4 chunks (which equals to one page of size 256).

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_write_firmware_pointer(device::BrickletRS232V2, pointer)
    device.deviceInternal.set_write_firmware_pointer(pointer)
end

export write_firmware
"""
    $(SIGNATURES)

Writes 64 Bytes of firmware at the position as written by
:func:`Set Write Firmware Pointer` before. The firmware is written
to flash every 4 chunks.

You can only write firmware in bootloader mode.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function write_firmware(device::BrickletRS232V2, data)
    return device.deviceInternal.write_firmware(data)
end

export set_status_led_config
"""
    $(SIGNATURES)

Sets the status LED configuration. By default the LED shows
communication traffic between Brick and Bricklet, it flickers once
for every 10 received data packets.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is will show heartbeat by default.
"""
function set_status_led_config(device::BrickletRS232V2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletRS232V2)
    return device.deviceInternal.get_status_led_config()
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature as measured inside the microcontroller. The
value returned is not the ambient temperature!

The temperature is only proportional to the real temperature and it has bad
accuracy. Practically it is only useful as an indicator for
temperature changes.
"""
function get_chip_temperature(device::BrickletRS232V2)
    return device.deviceInternal.get_chip_temperature()
end

export reset
"""
    $(SIGNATURES)

Calling this function will reset the Bricklet. All configurations
will be lost.

After a reset you have to create new device objects,
calling functions on the existing ones will result in
undefined behavior!
"""
function reset(device::BrickletRS232V2)
    device.deviceInternal.reset()
end

export write_uid
"""
    $(SIGNATURES)

Writes a new UID into flash. If you want to set a new UID
you have to decode the Base58 encoded UID string into an
integer first.

We recommend that you use Brick Viewer to change the UID.
"""
function write_uid(device::BrickletRS232V2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletRS232V2)
    return device.deviceInternal.read_uid()
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
function get_identity(device::BrickletRS232V2)
    return device.deviceInternal.get_identity()
end

export write
"""
Writes characters to the RS232 interface. The characters can be binary data,
ASCII or similar is not necessary.

The return value is the number of characters that were written.

See :func:`Set Configuration` for configuration possibilities
regarding baud rate, parity and so on.
"""
function write(device::BrickletRS232V2, message)

        message = convert(Vector{String}, message)

    if length(message) > 65535
        throw(TinkerforgeInvalidParameterError("Message can be at most 65535 items long"))
    end

    message_length = length(message)
    message_chunk_offset = 0

    if message_length == 0
        message_chunk_data = ['\0'] * 60
        ret = write_low_level(device, message_length, message_chunk_offset, message_chunk_data)
        message_written = ret
    else
        message_written = 0

        lock(device.stream_lock) do
            while message_chunk_offset < message_length
                message_chunk_data = create_chunk_data(message, message_chunk_offset, 60, '\0')
                ret = write_low_level(device, message_length, message_chunk_offset, message_chunk_data)
                message_written += ret

                if ret < 60
                    break # either last chunk or short write
                end

                message_chunk_offset += 60
            end
        end
    end

        return message_written
end

export read
"""
Returns up to *length* characters from receive buffer.

Instead of polling with this function, you can also use
callbacks. But note that this function will return available
data only when the read callback is disabled.
See :func:`Enable Read Callback` and :cb:`Read` callback.
"""
function read(device::BrickletRS232V2, length)

        length = UInt16(length)

    lock(device.stream_lock) do
        ret = read_low_level(device, length)
            message_length = ret.message_length
        message_out_of_sync = ret.message_chunk_offset != 0

        message_data = ret.message_chunk_data

        while !message_out_of_sync && length(message_data) < message_length
            ret = read_low_level(device, length)
                message_length = ret.message_length
            message_out_of_sync = ret.message_chunk_offset != length(message_data)
            message_data += ret.message_chunk_data
        end

        if message_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.message_chunk_offset + 60 < message_length
                ret = read_low_level(device, length)
                    message_length = ret.message_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Message stream is out-of-sync"))
        end
    end

        return message_data[:message_length]
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRS232V2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
