


export BrickletLEDStripV2LEDValuesLowLevel
struct BrickletLEDStripV2LEDValuesLowLevel
    value_length::Integer
    value_chunk_offset::Integer
    value_chunk_data::Vector{Integer}
end

export BrickletLEDStripV2SPITFPErrorCount
struct BrickletLEDStripV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletLEDStripV2Identity
struct BrickletLEDStripV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletLEDStripV2
"""
Controls up to 2048 RGB(W) LEDs
"""
mutable struct BrickletLEDStripV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletLEDStripV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_led_strip_v2")
        deviceInternal = package.BrickletLEDStripV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_led_values_low_level
"""
    $(SIGNATURES)

Sets the RGB(W) values for the LEDs starting from *index*.
You can set at most 2048 RGB values or 1536 RGBW values (6144 byte each).

To make the colors show correctly you need to configure the chip type
(see :func:`Set Chip Type`) and a channel mapping (see :func:`Set Channel Mapping`)
according to the connected LEDs.

If the channel mapping has 3 colors, you need to give the data in the sequence
RGBRGBRGB... if the channel mapping has 4 colors you need to give data in the
sequence RGBWRGBWRGBW...

The data is double buffered and the colors will be transfered to the
LEDs when the next frame duration ends (see :func:`Set Frame Duration`).

Generic approach:

* Set the frame duration to a value that represents the number of frames per
  second you want to achieve.
* Set all of the LED colors for one frame.
* Wait for the :cb:`Frame Started` callback.
* Set all of the LED colors for next frame.
* Wait for the :cb:`Frame Started` callback.
* And so on.

This approach ensures that you can change the LED colors with a fixed frame rate.
"""
function set_led_values_low_level(device::BrickletLEDStripV2, index, value_length, value_chunk_offset, value_chunk_data)
    device.deviceInternal.set_led_values_low_level(index, value_length, value_chunk_offset, value_chunk_data)
end

export get_led_values_low_level
"""
    $(SIGNATURES)

Returns *length* RGB(W) values starting from the
given *index*.

If the channel mapping has 3 colors, you will get the data in the sequence
RGBRGBRGB... if the channel mapping has 4 colors you will get the data in the
sequence RGBWRGBWRGBW...
(assuming you start at an index divisible by 3 (RGB) or 4 (RGBW)).
"""
function get_led_values_low_level(device::BrickletLEDStripV2, index, length)
    return device.deviceInternal.get_led_values_low_level(index, length)
end

export set_frame_duration
"""
    $(SIGNATURES)

Sets the frame duration.

Example: If you want to achieve 20 frames per second, you should
set the frame duration to 50ms (50ms * 20 = 1 second).

For an explanation of the general approach see :func:`Set LED Values`.

Default value: 100ms (10 frames per second).
"""
function set_frame_duration(device::BrickletLEDStripV2, duration)
    device.deviceInternal.set_frame_duration(duration)
end

export get_frame_duration
"""
    $(SIGNATURES)

Returns the frame duration as set by :func:`Set Frame Duration`.
"""
function get_frame_duration(device::BrickletLEDStripV2)
    return device.deviceInternal.get_frame_duration()
end

export get_supply_voltage
"""
    $(SIGNATURES)

Returns the current supply voltage of the LEDs.
"""
function get_supply_voltage(device::BrickletLEDStripV2)
    return device.deviceInternal.get_supply_voltage()
end

export set_clock_frequency
"""
    $(SIGNATURES)

Sets the frequency of the clock.

The Bricklet will choose the nearest achievable frequency, which may
be off by a few Hz. You can get the exact frequency that is used by
calling :func:`Get Clock Frequency`.

If you have problems with flickering LEDs, they may be bits flipping. You
can fix this by either making the connection between the LEDs and the
Bricklet shorter or by reducing the frequency.

With a decreasing frequency your maximum frames per second will decrease
too.
"""
function set_clock_frequency(device::BrickletLEDStripV2, frequency)
    device.deviceInternal.set_clock_frequency(frequency)
end

export get_clock_frequency
"""
    $(SIGNATURES)

Returns the currently used clock frequency as set by :func:`Set Clock Frequency`.
"""
function get_clock_frequency(device::BrickletLEDStripV2)
    return device.deviceInternal.get_clock_frequency()
end

export set_chip_type
"""
    $(SIGNATURES)

Sets the type of the LED driver chip. We currently support the chips

* WS2801,
* WS2811,
* WS2812 / SK6812 / NeoPixel RGB,
* SK6812RGBW / NeoPixel RGBW (Chip Type = WS2812),
* WS2813 / WS2815 (Chip Type = WS2812)
* LPD8806 and
* APA102 / DotStar.
"""
function set_chip_type(device::BrickletLEDStripV2, chip)
    device.deviceInternal.set_chip_type(chip)
end

export get_chip_type
"""
    $(SIGNATURES)

Returns the currently used chip type as set by :func:`Set Chip Type`.
"""
function get_chip_type(device::BrickletLEDStripV2)
    return device.deviceInternal.get_chip_type()
end

export set_channel_mapping
"""
    $(SIGNATURES)

Sets the channel mapping for the connected LEDs.

If the mapping has 4 colors, the function :func:`Set LED Values` expects 4
values per pixel and if the mapping has 3 colors it expects 3 values per pixel.

The function always expects the order RGB(W). The connected LED driver chips
might have their 3 or 4 channels in a different order. For example, the WS2801
chips typically use BGR order, then WS2812 chips typically use GRB order and
the APA102 chips typically use WBGR order.

The APA102 chips are special. They have three 8-bit channels for RGB
and an additional 5-bit channel for the overall brightness of the RGB LED
making them 4-channel chips. Internally the brightness channel is the first
channel, therefore one of the Wxyz channel mappings should be used. Then
the W channel controls the brightness.
"""
function set_channel_mapping(device::BrickletLEDStripV2, mapping)
    device.deviceInternal.set_channel_mapping(mapping)
end

export get_channel_mapping
"""
    $(SIGNATURES)

Returns the currently used channel mapping as set by :func:`Set Channel Mapping`.
"""
function get_channel_mapping(device::BrickletLEDStripV2)
    return device.deviceInternal.get_channel_mapping()
end

export set_frame_started_callback_configuration
"""
    $(SIGNATURES)

Enables/disables the :cb:`Frame Started` callback.
"""
function set_frame_started_callback_configuration(device::BrickletLEDStripV2, enable)
    device.deviceInternal.set_frame_started_callback_configuration(enable)
end

export get_frame_started_callback_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by
:func:`Set Frame Started Callback Configuration`.
"""
function get_frame_started_callback_configuration(device::BrickletLEDStripV2)
    return device.deviceInternal.get_frame_started_callback_configuration()
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
function get_spitfp_error_count(device::BrickletLEDStripV2)
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
function set_bootloader_mode(device::BrickletLEDStripV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletLEDStripV2)
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
function set_write_firmware_pointer(device::BrickletLEDStripV2, pointer)
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
function write_firmware(device::BrickletLEDStripV2, data)
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
function set_status_led_config(device::BrickletLEDStripV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletLEDStripV2)
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
function get_chip_temperature(device::BrickletLEDStripV2)
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
function reset(device::BrickletLEDStripV2)
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
function write_uid(device::BrickletLEDStripV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletLEDStripV2)
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
function get_identity(device::BrickletLEDStripV2)
    return device.deviceInternal.get_identity()
end

export set_led_values
"""
Sets the RGB(W) values for the LEDs starting from *index*.
You can set at most 2048 RGB values or 1536 RGBW values (6144 byte each).

To make the colors show correctly you need to configure the chip type
(see :func:`Set Chip Type`) and a channel mapping (see :func:`Set Channel Mapping`)
according to the connected LEDs.

If the channel mapping has 3 colors, you need to give the data in the sequence
RGBRGBRGB... if the channel mapping has 4 colors you need to give data in the
sequence RGBWRGBWRGBW...

The data is double buffered and the colors will be transfered to the
LEDs when the next frame duration ends (see :func:`Set Frame Duration`).

Generic approach:

* Set the frame duration to a value that represents the number of frames per
  second you want to achieve.
* Set all of the LED colors for one frame.
* Wait for the :cb:`Frame Started` callback.
* Set all of the LED colors for next frame.
* Wait for the :cb:`Frame Started` callback.
* And so on.

This approach ensures that you can change the LED colors with a fixed frame rate.
"""
function set_led_values(device::BrickletLEDStripV2, index, value)

        index = UInt16(index)
    value = convert(Vector{UInt8}, value)

    if length(value) > 65535
        throw(TinkerforgeInvalidParameterError("Value can be at most 65535 items long"))
    end

    value_length = length(value)
    value_chunk_offset = 0

    if value_length == 0
        value_chunk_data = [0] * 58
        ret = set_led_values_low_level(device, index, value_length, value_chunk_offset, value_chunk_data)
    else
        lock(device.stream_lock) do
            while value_chunk_offset < value_length
                value_chunk_data = create_chunk_data(value, value_chunk_offset, 58, 0)
                ret = set_led_values_low_level(device, index, value_length, value_chunk_offset, value_chunk_data)
                value_chunk_offset += 58
            end
        end
    end

        return ret
end

export get_led_values
"""
Returns *length* RGB(W) values starting from the
given *index*.

If the channel mapping has 3 colors, you will get the data in the sequence
RGBRGBRGB... if the channel mapping has 4 colors you will get the data in the
sequence RGBWRGBWRGBW...
(assuming you start at an index divisible by 3 (RGB) or 4 (RGBW)).
"""
function get_led_values(device::BrickletLEDStripV2, index, length)

        index = UInt16(index)
    length = UInt16(length)

    lock(device.stream_lock) do
        ret = get_led_values_low_level(device, index, length)
            value_length = ret.value_length
        value_out_of_sync = ret.value_chunk_offset != 0

        value_data = ret.value_chunk_data

        while !value_out_of_sync && length(value_data) < value_length
            ret = get_led_values_low_level(device, index, length)
                value_length = ret.value_length
            value_out_of_sync = ret.value_chunk_offset != length(value_data)
            value_data += ret.value_chunk_data
        end

        if value_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.value_chunk_offset + 60 < value_length
                ret = get_led_values_low_level(device, index, length)
                    value_length = ret.value_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Value stream is out-of-sync"))
        end
    end

        return value_data[:value_length]
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletLEDStripV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
