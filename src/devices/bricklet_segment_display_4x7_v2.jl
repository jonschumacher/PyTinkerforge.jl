


export BrickletSegmentDisplay4x7V2Segments
struct BrickletSegmentDisplay4x7V2Segments
    digit0::Vector{Bool}
    digit1::Vector{Bool}
    digit2::Vector{Bool}
    digit3::Vector{Bool}
    colon::Vector{Bool}
    tick::Bool
end

export BrickletSegmentDisplay4x7V2SPITFPErrorCount
struct BrickletSegmentDisplay4x7V2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletSegmentDisplay4x7V2Identity
struct BrickletSegmentDisplay4x7V2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletSegmentDisplay4x7V2
"""
Four 7-segment displays with switchable dots
"""
mutable struct BrickletSegmentDisplay4x7V2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletSegmentDisplay4x7V2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_segment_display_4x7_v2")
        deviceInternal = package.BrickletSegmentDisplay4x7V2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_segments
"""
    $(SIGNATURES)

Sets the segments of the Segment Display 4x7 Bricklet 2.0 segment-by-segment.

The data is split into the four digits, two colon dots and the tick mark.

The indices of the segments in the digit and colon parameters are as follows:

.. image:: /Images/Bricklets/bricklet_segment_display_4x7_v2_segment_index.png
   :scale: 100 %
   :alt: Indices of segments
   :align: center
"""
function set_segments(device::BrickletSegmentDisplay4x7V2, digit0, digit1, digit2, digit3, colon, tick)
    device.deviceInternal.set_segments(digit0, digit1, digit2, digit3, colon, tick)
end

export get_segments
"""
    $(SIGNATURES)

Returns the segment data as set by :func:`Set Segments`.
"""
function get_segments(device::BrickletSegmentDisplay4x7V2)
    return device.deviceInternal.get_segments()
end

export set_brightness
"""
    $(SIGNATURES)

The brightness can be set between 0 (dark) and 7 (bright).
"""
function set_brightness(device::BrickletSegmentDisplay4x7V2, brightness)
    device.deviceInternal.set_brightness(brightness)
end

export get_brightness
"""
    $(SIGNATURES)

Returns the brightness as set by :func:`Set Brightness`.
"""
function get_brightness(device::BrickletSegmentDisplay4x7V2)
    return device.deviceInternal.get_brightness()
end

export set_numeric_value
"""
    $(SIGNATURES)

Sets a numeric value for each of the digits. They represent:

* -2: minus sign
* -1: blank
* 0-9: 0-9
* 10: A
* 11: b
* 12: C
* 13: d
* 14: E
* 15: F

Example: A call with [-2, -1, 4, 2] will result in a display of "- 42".
"""
function set_numeric_value(device::BrickletSegmentDisplay4x7V2, value)
    device.deviceInternal.set_numeric_value(value)
end

export set_selected_segment
"""
    $(SIGNATURES)

Turns one specified segment on or off.

The indices of the segments are as follows:

.. image:: /Images/Bricklets/bricklet_segment_display_4x7_v2_selected_segment_index.png
   :scale: 100 %
   :alt: Indices of selected segments
   :align: center
"""
function set_selected_segment(device::BrickletSegmentDisplay4x7V2, segment, value)
    device.deviceInternal.set_selected_segment(segment, value)
end

export get_selected_segment
"""
    $(SIGNATURES)

Returns the value of a single segment.
"""
function get_selected_segment(device::BrickletSegmentDisplay4x7V2, segment)
    return device.deviceInternal.get_selected_segment(segment)
end

export start_counter
"""
    $(SIGNATURES)

Starts a counter with the *from* value that counts to the *to*
value with the each step incremented by *increment*.
*length* is the pause between each increment.

Example: If you set *from* to 0, *to* to 100, *increment* to 1 and
*length* to 1000, a counter that goes from 0 to 100 with one second
pause between each increment will be started.

Using a negative *increment* allows to count backwards.

You can stop the counter at every time by calling :func:`Set Segments`
or :func:`Set Numeric Value`.
"""
function start_counter(device::BrickletSegmentDisplay4x7V2, value_from, value_to, increment, length)
    device.deviceInternal.start_counter(value_from, value_to, increment, length)
end

export get_counter_value
"""
    $(SIGNATURES)

Returns the counter value that is currently shown on the display.

If there is no counter running a 0 will be returned.
"""
function get_counter_value(device::BrickletSegmentDisplay4x7V2)
    return device.deviceInternal.get_counter_value()
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
function get_spitfp_error_count(device::BrickletSegmentDisplay4x7V2)
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
function set_bootloader_mode(device::BrickletSegmentDisplay4x7V2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletSegmentDisplay4x7V2)
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
function set_write_firmware_pointer(device::BrickletSegmentDisplay4x7V2, pointer)
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
function write_firmware(device::BrickletSegmentDisplay4x7V2, data)
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
function set_status_led_config(device::BrickletSegmentDisplay4x7V2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletSegmentDisplay4x7V2)
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
function get_chip_temperature(device::BrickletSegmentDisplay4x7V2)
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
function reset(device::BrickletSegmentDisplay4x7V2)
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
function write_uid(device::BrickletSegmentDisplay4x7V2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletSegmentDisplay4x7V2)
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
function get_identity(device::BrickletSegmentDisplay4x7V2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletSegmentDisplay4x7V2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
