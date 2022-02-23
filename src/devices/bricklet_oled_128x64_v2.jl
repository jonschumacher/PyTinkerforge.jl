


export BrickletOLED128x64V2ReadPixelsLowLevel
struct BrickletOLED128x64V2ReadPixelsLowLevel
    pixels_length::Integer
    pixels_chunk_offset::Integer
    pixels_chunk_data::Vector{Bool}
end

export BrickletOLED128x64V2DisplayConfiguration
struct BrickletOLED128x64V2DisplayConfiguration
    contrast::Integer
    invert::Bool
    automatic_draw::Bool
end

export BrickletOLED128x64V2SPITFPErrorCount
struct BrickletOLED128x64V2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletOLED128x64V2Identity
struct BrickletOLED128x64V2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletOLED128x64V2
"""
3.3cm (1.3") OLED display with 128x64 pixels
"""
mutable struct BrickletOLED128x64V2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletOLED128x64V2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_oled_128x64_v2")
        deviceInternal = package.BrickletOLED128x64V2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write_pixels_low_level
"""
    $(SIGNATURES)

Writes pixels to the specified window.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

If automatic draw is enabled (default) the pixels are directly written to
the screen. Only pixels that have actually changed are updated on the screen,
the rest stays the same.

If automatic draw is disabled the pixels are written to an internal buffer and
the buffer is transferred to the display only after :func:`Draw Buffered Frame`
is called. This can be used to avoid flicker when drawing a complex frame in
multiple steps.

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function write_pixels_low_level(device::BrickletOLED128x64V2, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
    device.deviceInternal.write_pixels_low_level(x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
end

export read_pixels_low_level
"""
    $(SIGNATURES)

Reads pixels from the specified window.

The pixels are read from the window line by line top to bottom
and each line is read from left to right.

If automatic draw is enabled (default) the pixels that are read are always the
same that are shown on the display.

If automatic draw is disabled the pixels are read from the internal buffer
(see :func:`Draw Buffered Frame`).

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function read_pixels_low_level(device::BrickletOLED128x64V2, x_start, y_start, x_end, y_end)
    return device.deviceInternal.read_pixels_low_level(x_start, y_start, x_end, y_end)
end

export clear_display
"""
    $(SIGNATURES)

Clears the complete content of the display.

If automatic draw is enabled (default) the pixels are directly cleared.

If automatic draw is disabled the the internal buffer is cleared and
the buffer is transferred to the display only after :func:`Draw Buffered Frame`
is called. This can be used to avoid flicker when drawing a complex frame in
multiple steps.

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function clear_display(device::BrickletOLED128x64V2)
    device.deviceInternal.clear_display()
end

export set_display_configuration
"""
    $(SIGNATURES)

Sets the configuration of the display.

You can set a contrast value from 0 to 255 and you can invert the color
(white/black) of the display.

If automatic draw is set to *true*, the display is automatically updated with every
call of :func:`Write Pixels` or :func:`Write Line`. If it is set to false, the
changes are written into an internal buffer and only shown on the display after
a call of :func:`Draw Buffered Frame`.
"""
function set_display_configuration(device::BrickletOLED128x64V2, contrast, invert, automatic_draw)
    device.deviceInternal.set_display_configuration(contrast, invert, automatic_draw)
end

export get_display_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Display Configuration`.
"""
function get_display_configuration(device::BrickletOLED128x64V2)
    return device.deviceInternal.get_display_configuration()
end

export write_line
"""
    $(SIGNATURES)

Writes text to a specific line with a specific position.
The text can have a maximum of 22 characters.

For example: (1, 10, "Hello") will write *Hello* in the middle of the
second line of the display.

The display uses a special 5x7 pixel charset. You can view the characters
of the charset in Brick Viewer.

If automatic draw is enabled (default) the text is directly written to
the screen. Only pixels that have actually changed are updated on the screen,
the rest stays the same.

If automatic draw is disabled the text is written to an internal buffer and
the buffer is transferred to the display only after :func:`Draw Buffered Frame`
is called. This can be used to avoid flicker when drawing a complex frame in
multiple steps.

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function write_line(device::BrickletOLED128x64V2, line, position, text)
    device.deviceInternal.write_line(line, position, text)
end

export draw_buffered_frame
"""
    $(SIGNATURES)

Draws the currently buffered frame. Normally each call of :func:`Write Pixels` and
:func:`Write Line` draws directly onto the display. If you turn automatic draw off
(:func:`Set Display Configuration`), the data is written in an internal buffer and
only transferred to the display by calling this function. This can be used to
avoid flicker when drawing a complex frame in multiple steps.

Set the `force complete redraw` to *true* to redraw the whole display
instead of only the changed parts. Normally it should not be necessary to set this to
*true*. It may only become necessary in case of stuck pixels because of errors.
"""
function draw_buffered_frame(device::BrickletOLED128x64V2, force_complete_redraw)
    device.deviceInternal.draw_buffered_frame(force_complete_redraw)
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
function get_spitfp_error_count(device::BrickletOLED128x64V2)
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
function set_bootloader_mode(device::BrickletOLED128x64V2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletOLED128x64V2)
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
function set_write_firmware_pointer(device::BrickletOLED128x64V2, pointer)
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
function write_firmware(device::BrickletOLED128x64V2, data)
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
function set_status_led_config(device::BrickletOLED128x64V2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletOLED128x64V2)
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
function get_chip_temperature(device::BrickletOLED128x64V2)
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
function reset(device::BrickletOLED128x64V2)
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
function write_uid(device::BrickletOLED128x64V2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletOLED128x64V2)
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
function get_identity(device::BrickletOLED128x64V2)
    return device.deviceInternal.get_identity()
end

export write_pixels
"""
Writes pixels to the specified window.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

If automatic draw is enabled (default) the pixels are directly written to
the screen. Only pixels that have actually changed are updated on the screen,
the rest stays the same.

If automatic draw is disabled the pixels are written to an internal buffer and
the buffer is transferred to the display only after :func:`Draw Buffered Frame`
is called. This can be used to avoid flicker when drawing a complex frame in
multiple steps.

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function write_pixels(device::BrickletOLED128x64V2, x_start, y_start, x_end, y_end, pixels)

        x_start = UInt8(x_start)
    y_start = UInt8(y_start)
    x_end = UInt8(x_end)
    y_end = UInt8(y_end)
    pixels = convert(Vector{Bool}, pixels)

    if length(pixels) > 65535
        throw(TinkerforgeInvalidParameterError("Pixels can be at most 65535 items long"))
    end

    pixels_length = length(pixels)
    pixels_chunk_offset = 0

    if pixels_length == 0
        pixels_chunk_data = [False] * 448
        ret = write_pixels_low_level(device, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
    else
        lock(device.stream_lock) do
            while pixels_chunk_offset < pixels_length
                pixels_chunk_data = create_chunk_data(pixels, pixels_chunk_offset, 448, False)
                ret = write_pixels_low_level(device, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
                pixels_chunk_offset += 448
            end
        end
    end

        return ret
end

export read_pixels
"""
Reads pixels from the specified window.

The pixels are read from the window line by line top to bottom
and each line is read from left to right.

If automatic draw is enabled (default) the pixels that are read are always the
same that are shown on the display.

If automatic draw is disabled the pixels are read from the internal buffer
(see :func:`Draw Buffered Frame`).

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function read_pixels(device::BrickletOLED128x64V2, x_start, y_start, x_end, y_end)

        x_start = UInt8(x_start)
    y_start = UInt8(y_start)
    x_end = UInt8(x_end)
    y_end = UInt8(y_end)

    lock(device.stream_lock) do
        ret = read_pixels_low_level(device, x_start, y_start, x_end, y_end)
            pixels_length = ret.pixels_length
        pixels_out_of_sync = ret.pixels_chunk_offset != 0

        pixels_data = ret.pixels_chunk_data

        while !pixels_out_of_sync && length(pixels_data) < pixels_length
            ret = read_pixels_low_level(device, x_start, y_start, x_end, y_end)
                pixels_length = ret.pixels_length
            pixels_out_of_sync = ret.pixels_chunk_offset != length(pixels_data)
            pixels_data += ret.pixels_chunk_data
        end

        if pixels_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.pixels_chunk_offset + 480 < pixels_length
                ret = read_pixels_low_level(device, x_start, y_start, x_end, y_end)
                    pixels_length = ret.pixels_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Pixels stream is out-of-sync"))
        end
    end

        return pixels_data[:pixels_length]
end
