


export BrickletDMXReadFrameLowLevel
struct BrickletDMXReadFrameLowLevel
    frame_length::Integer
    frame_chunk_offset::Integer
    frame_chunk_data::Vector{Integer}
    frame_number::Integer
end

export BrickletDMXFrameErrorCount
struct BrickletDMXFrameErrorCount
    overrun_error_count::Integer
    framing_error_count::Integer
end

export BrickletDMXFrameCallbackConfig
struct BrickletDMXFrameCallbackConfig
    frame_started_callback_enabled::Bool
    frame_available_callback_enabled::Bool
    frame_callback_enabled::Bool
    frame_error_count_callback_enabled::Bool
end

export BrickletDMXSPITFPErrorCount
struct BrickletDMXSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletDMXIdentity
struct BrickletDMXIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletDMXReadFrame
struct BrickletDMXReadFrame
    frame::Vector{Integer}
    frame_number::Integer
end

export BrickletDMX
"""
DMX master and slave
"""
mutable struct BrickletDMX <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletDMX(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_dmx")
        deviceInternal = package.BrickletDMX(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_dmx_mode
"""
    $(SIGNATURES)

Sets the DMX mode to either master or slave.

Calling this function sets frame number to 0.
"""
function set_dmx_mode(device::BrickletDMX, dmx_mode)
    device.deviceInternal.set_dmx_mode(dmx_mode)
end

export get_dmx_mode
"""
    $(SIGNATURES)

Returns the DMX mode, as set by :func:`Set DMX Mode`.
"""
function get_dmx_mode(device::BrickletDMX)
    return device.deviceInternal.get_dmx_mode()
end

export write_frame_low_level
"""
    $(SIGNATURES)

Writes a DMX frame. The maximum frame size is 512 byte. Each byte represents one channel.

The next frame can be written after the :cb:`Frame Started` callback was called. The frame
is double buffered, so a new frame can be written as soon as the writing of the prior frame
starts.

The data will be transfered when the next frame duration ends, see :func:`Set Frame Duration`.

Generic approach:

* Set the frame duration to a value that represents the number of frames per second you want to achieve.
* Set channels for first frame.
* Wait for the :cb:`Frame Started` callback.
* Set channels for next frame.
* Wait for the :cb:`Frame Started` callback.
* and so on.

This approach ensures that you can set new DMX data with a fixed frame rate.

This function can only be called in master mode.
"""
function write_frame_low_level(device::BrickletDMX, frame_length, frame_chunk_offset, frame_chunk_data)
    device.deviceInternal.write_frame_low_level(frame_length, frame_chunk_offset, frame_chunk_data)
end

export read_frame_low_level
"""
    $(SIGNATURES)

Returns the last frame that was written by the DMX master. The size of the array
is equivalent to the number of channels in the frame. Each byte represents one channel.

The next frame is available after the :cb:`Frame Available` callback was called.

Generic approach:

* Call :func:`Read Frame` to get first frame.
* Wait for the :cb:`Frame Available` callback.
* Call :func:`Read Frame` to get second frame.
* Wait for the :cb:`Frame Available` callback.
* and so on.

Instead of polling this function you can also use the :cb:`Frame` callback.
You can enable it with :func:`Set Frame Callback Config`.

The frame number starts at 0 and it is increased by one with each received frame.

This function can only be called in slave mode.
"""
function read_frame_low_level(device::BrickletDMX)
    return device.deviceInternal.read_frame_low_level()
end

export set_frame_duration
"""
    $(SIGNATURES)

Sets the duration of a frame.

Example: If you want to achieve 20 frames per second, you should
set the frame duration to 50ms (50ms * 20 = 1 second).

If you always want to send a frame as fast as possible you can set
this value to 0.

This setting is only used in master mode.
"""
function set_frame_duration(device::BrickletDMX, frame_duration)
    device.deviceInternal.set_frame_duration(frame_duration)
end

export get_frame_duration
"""
    $(SIGNATURES)

Returns the frame duration as set by :func:`Set Frame Duration`.
"""
function get_frame_duration(device::BrickletDMX)
    return device.deviceInternal.get_frame_duration()
end

export get_frame_error_count
"""
    $(SIGNATURES)

Returns the current number of overrun and framing errors.
"""
function get_frame_error_count(device::BrickletDMX)
    return device.deviceInternal.get_frame_error_count()
end

export set_communication_led_config
"""
    $(SIGNATURES)

Sets the communication LED configuration. By default the LED shows
communication traffic, it flickers once for every 10 received data packets.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is off.
"""
function set_communication_led_config(device::BrickletDMX, config)
    device.deviceInternal.set_communication_led_config(config)
end

export get_communication_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Communication LED Config`
"""
function get_communication_led_config(device::BrickletDMX)
    return device.deviceInternal.get_communication_led_config()
end

export set_error_led_config
"""
    $(SIGNATURES)

Sets the error LED configuration.

By default the error LED turns on if there is any error (see :cb:`Frame Error Count`
callback). If you call this function with the Show-Error option again, the LED
will turn off until the next error occurs.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is off.
"""
function set_error_led_config(device::BrickletDMX, config)
    device.deviceInternal.set_error_led_config(config)
end

export get_error_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Error LED Config`.
"""
function get_error_led_config(device::BrickletDMX)
    return device.deviceInternal.get_error_led_config()
end

export set_frame_callback_config
"""
    $(SIGNATURES)

Enables/Disables the different callbacks. By default the
:cb:`Frame Started` callback and :cb:`Frame Available` callback are enabled while
the :cb:`Frame` callback and :cb:`Frame Error Count` callback are disabled.

If you want to use the :cb:`Frame` callback you can enable it and disable
the cb:`Frame Available` callback at the same time. It becomes redundant in
this case.
"""
function set_frame_callback_config(device::BrickletDMX, frame_started_callback_enabled, frame_available_callback_enabled, frame_callback_enabled, frame_error_count_callback_enabled)
    device.deviceInternal.set_frame_callback_config(frame_started_callback_enabled, frame_available_callback_enabled, frame_callback_enabled, frame_error_count_callback_enabled)
end

export get_frame_callback_config
"""
    $(SIGNATURES)

Returns the frame callback config as set by :func:`Set Frame Callback Config`.
"""
function get_frame_callback_config(device::BrickletDMX)
    return device.deviceInternal.get_frame_callback_config()
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
function get_spitfp_error_count(device::BrickletDMX)
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
function set_bootloader_mode(device::BrickletDMX, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletDMX)
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
function set_write_firmware_pointer(device::BrickletDMX, pointer)
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
function write_firmware(device::BrickletDMX, data)
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
function set_status_led_config(device::BrickletDMX, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletDMX)
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
function get_chip_temperature(device::BrickletDMX)
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
function reset(device::BrickletDMX)
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
function write_uid(device::BrickletDMX, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletDMX)
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
function get_identity(device::BrickletDMX)
    return device.deviceInternal.get_identity()
end

export write_frame
"""
Writes a DMX frame. The maximum frame size is 512 byte. Each byte represents one channel.

The next frame can be written after the :cb:`Frame Started` callback was called. The frame
is double buffered, so a new frame can be written as soon as the writing of the prior frame
starts.

The data will be transfered when the next frame duration ends, see :func:`Set Frame Duration`.

Generic approach:

* Set the frame duration to a value that represents the number of frames per second you want to achieve.
* Set channels for first frame.
* Wait for the :cb:`Frame Started` callback.
* Set channels for next frame.
* Wait for the :cb:`Frame Started` callback.
* and so on.

This approach ensures that you can set new DMX data with a fixed frame rate.

This function can only be called in master mode.
"""
function write_frame(device::BrickletDMX, frame)

        frame = convert(Vector{UInt8}, frame)

    if length(frame) > 65535
        throw(TinkerforgeInvalidParameterError("Frame can be at most 65535 items long"))
    end

    frame_length = length(frame)
    frame_chunk_offset = 0

    if frame_length == 0
        frame_chunk_data = [0] * 60
        ret = write_frame_low_level(device, frame_length, frame_chunk_offset, frame_chunk_data)
    else
        lock(device.stream_lock) do
            while frame_chunk_offset < frame_length
                frame_chunk_data = create_chunk_data(frame, frame_chunk_offset, 60, 0)
                ret = write_frame_low_level(device, frame_length, frame_chunk_offset, frame_chunk_data)
                frame_chunk_offset += 60
            end
        end
    end

        return ret
end

export read_frame
"""
Returns the last frame that was written by the DMX master. The size of the array
is equivalent to the number of channels in the frame. Each byte represents one channel.

The next frame is available after the :cb:`Frame Available` callback was called.

Generic approach:

* Call :func:`Read Frame` to get first frame.
* Wait for the :cb:`Frame Available` callback.
* Call :func:`Read Frame` to get second frame.
* Wait for the :cb:`Frame Available` callback.
* and so on.

Instead of polling this function you can also use the :cb:`Frame` callback.
You can enable it with :func:`Set Frame Callback Config`.

The frame number starts at 0 and it is increased by one with each received frame.

This function can only be called in slave mode.
"""
function read_frame(device::BrickletDMX)

    lock(device.stream_lock) do
        ret = read_frame_low_level(device, )
            frame_length = ret.frame_length
        frame_out_of_sync = ret.frame_chunk_offset != 0

        frame_data = ret.frame_chunk_data

        while !frame_out_of_sync && length(frame_data) < frame_length
            ret = read_frame_low_level(device, )
                frame_length = ret.frame_length
            frame_out_of_sync = ret.frame_chunk_offset != length(frame_data)
            frame_data += ret.frame_chunk_data
        end

        if frame_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.frame_chunk_offset + 56 < frame_length
                ret = read_frame_low_level(device, )
                    frame_length = ret.frame_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Frame stream is out-of-sync"))
        end
    end

        return ReadFrame(frame_data[:frame_length], ret.frame_number)
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletDMX, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
