


export BrickletEPaper296x128ReadBlackWhiteLowLevel
struct BrickletEPaper296x128ReadBlackWhiteLowLevel
    pixels_length::Integer
    pixels_chunk_offset::Integer
    pixels_chunk_data::Vector{Bool}
end

export BrickletEPaper296x128ReadColorLowLevel
struct BrickletEPaper296x128ReadColorLowLevel
    pixels_length::Integer
    pixels_chunk_offset::Integer
    pixels_chunk_data::Vector{Bool}
end

export BrickletEPaper296x128SPITFPErrorCount
struct BrickletEPaper296x128SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletEPaper296x128Identity
struct BrickletEPaper296x128Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletEPaper296x128
"""
Three color 296x128 e-paper display
"""
mutable struct BrickletEPaper296x128 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletEPaper296x128(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_e_paper_296x128")
        deviceInternal = package.BrickletEPaper296x128(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export draw
"""
    $(SIGNATURES)

Draws the current black/white and red or gray buffer to the e-paper display.

The Bricklet does not have any double-buffering. You should not call
this function while writing to the buffer. See :func:`Get Draw Status`.
"""
function draw(device::BrickletEPaper296x128)
    device.deviceInternal.draw()
end

export get_draw_status
"""
    $(SIGNATURES)

Returns one of three draw statuses:

* Idle
* Copying: Data is being copied from the buffer of the Bricklet to the buffer of the display.
* Drawing: The display is updating its content (during this phase the flickering etc happens).

You can write to the buffer (through one of the write or draw functions) when the status is
either *idle* or *drawing*. You should not write to the buffer while it is being *copied* to the
display. There is no double-buffering.
"""
function get_draw_status(device::BrickletEPaper296x128)
    return device.deviceInternal.get_draw_status()
end

export write_black_white_low_level
"""
    $(SIGNATURES)

Writes black/white pixels to the specified window into the buffer.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

The value 0 (false) corresponds to a black pixel and the value 1 (true) to a
white pixel.

This function writes the pixels into the black/white pixel buffer, to draw the
buffer to the display use :func:`Draw`.

Use :func:`Write Color` to write red or gray pixels.
"""
function write_black_white_low_level(device::BrickletEPaper296x128, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
    device.deviceInternal.write_black_white_low_level(x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
end

export read_black_white_low_level
"""
    $(SIGNATURES)

Returns the current content of the black/white pixel buffer for the specified window.

The pixels are read into the window line by line top to bottom and
each line is read from left to right.

The current content of the buffer does not have to be the current content of the display.
It is possible that the data was not drawn to the display yet and after a restart of
the Bricklet the buffer will be reset to black, while the display retains its content.
"""
function read_black_white_low_level(device::BrickletEPaper296x128, x_start, y_start, x_end, y_end)
    return device.deviceInternal.read_black_white_low_level(x_start, y_start, x_end, y_end)
end

export write_color_low_level
"""
    $(SIGNATURES)

The E-Paper 296x128 Bricklet is available with the colors black/white/red and
black/white/gray. Depending on the model this function writes either red or
gray pixels to the specified window into the buffer.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

The value 0 (false) means that this pixel does not have color. It will be either black
or white (see :func:`Write Black White`). The value 1 (true) corresponds to a red or gray
pixel, depending on the Bricklet model.

This function writes the pixels into the red or gray pixel buffer, to draw the buffer
to the display use :func:`Draw`.

Use :func:`Write Black White` to write black/white pixels.
"""
function write_color_low_level(device::BrickletEPaper296x128, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
    device.deviceInternal.write_color_low_level(x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
end

export read_color_low_level
"""
    $(SIGNATURES)

Returns the current content of the red or gray pixel buffer for the specified window.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

The current content of the buffer does not have to be the current content of the display.
It is possible that the data was not drawn to the display yet and after a restart of
the Bricklet the buffer will be reset to black, while the display retains its content.
"""
function read_color_low_level(device::BrickletEPaper296x128, x_start, y_start, x_end, y_end)
    return device.deviceInternal.read_color_low_level(x_start, y_start, x_end, y_end)
end

export fill_display
"""
    $(SIGNATURES)

Fills the complete content of the display with the given color.

This function writes the pixels into the black/white/red|gray pixel buffer, to draw the buffer
to the display use :func:`Draw`.
"""
function fill_display(device::BrickletEPaper296x128, color)
    device.deviceInternal.fill_display(color)
end

export draw_text
"""
    $(SIGNATURES)

Draws a text with up to 50 characters at the pixel position (x, y).

You can use one of 9 different font sizes and draw the text in
black/white/red|gray. The text can be drawn horizontal or vertical.

This function writes the pixels into the black/white/red|gray pixel buffer, to draw the buffer
to the display use :func:`Draw`.
"""
function draw_text(device::BrickletEPaper296x128, position_x, position_y, font, color, orientation, text)
    device.deviceInternal.draw_text(position_x, position_y, font, color, orientation, text)
end

export draw_line
"""
    $(SIGNATURES)

Draws a line from (x, y)-start to (x, y)-end in the given color.

This function writes the pixels into the black/white/red|gray pixel buffer, to draw the buffer
to the display use :func:`Draw`.
"""
function draw_line(device::BrickletEPaper296x128, position_x_start, position_y_start, position_x_end, position_y_end, color)
    device.deviceInternal.draw_line(position_x_start, position_y_start, position_x_end, position_y_end, color)
end

export draw_box
"""
    $(SIGNATURES)

Draws a box from (x, y)-start to (x, y)-end in the given color.

If you set fill to true, the box will be filled with the
color. Otherwise only the outline will be drawn.

This function writes the pixels into the black/white/red|gray pixel buffer, to draw the buffer
to the display use :func:`Draw`.
"""
function draw_box(device::BrickletEPaper296x128, position_x_start, position_y_start, position_x_end, position_y_end, fill, color)
    device.deviceInternal.draw_box(position_x_start, position_y_start, position_x_end, position_y_end, fill, color)
end

export set_update_mode
"""
    $(SIGNATURES)

.. note::
 The default update mode corresponds to the default e-paper display
 manufacturer settings. All of the other modes are experimental and
 will result in increased ghosting and possibly other long-term
 side effects.

 If you want to know more about the inner workings of an e-paper display
 take a look at this excellent video from Ben Krasnow:
 `https://www.youtube.com/watch?v=MsbiO8EAsGw <https://www.youtube.com/watch?v=MsbiO8EAsGw>`__.

 If you are not sure about this option, leave the update mode at default.

Currently there are three update modes available:

* Default: Settings as given by the manufacturer. An update will take about
  7.5 seconds and during the update the screen will flicker several times.
* Black/White: This will only update the black/white pixel. It uses the manufacturer
  settings for black/white and ignores the red or gray pixel buffer. With this mode the
  display will flicker once and it takes about 2.5 seconds. Compared to the default settings
  there is more ghosting.
* Delta: This will only update the black/white pixel. It uses an aggressive method where
  the changes are not applied for a whole buffer but only for the delta between the last
  and the next buffer. With this mode the display will not flicker during an update and
  it takes about 900-950ms. Compared to the other two settings there is more ghosting. This
  mode can be used for something like a flicker-free live update of a text.

With the black/white/red display if you use either the black/white or the delta mode,
after a while of going back and forth between black and white the white color will
start to appear red-ish or pink-ish.

If you use the aggressive delta mode and rapidly change the content, we recommend that you
change back to the default mode every few hours and in the default mode cycle between the
three available colors a few times. This will get rid of the ghosting and after that you can
go back to the delta mode with flicker-free updates.
"""
function set_update_mode(device::BrickletEPaper296x128, update_mode)
    device.deviceInternal.set_update_mode(update_mode)
end

export get_update_mode
"""
    $(SIGNATURES)

Returns the update mode as set by :func:`Set Update Mode`.
"""
function get_update_mode(device::BrickletEPaper296x128)
    return device.deviceInternal.get_update_mode()
end

export set_display_type
"""
    $(SIGNATURES)

Sets the type of the display. The e-paper display is available
in black/white/red and black/white/gray. This will be factory set
during the flashing and testing phase. The value is saved in
non-volatile memory and will stay after a power cycle.
"""
function set_display_type(device::BrickletEPaper296x128, display_type)
    device.deviceInternal.set_display_type(display_type)
end

export get_display_type
"""
    $(SIGNATURES)

Returns the type of the e-paper display. It can either be
black/white/red or black/white/gray.
"""
function get_display_type(device::BrickletEPaper296x128)
    return device.deviceInternal.get_display_type()
end

export set_display_driver
"""
    $(SIGNATURES)

Sets the type of display driver. The Bricklet can currently support
SSD1675A and SSD1680. This will be factory set
during the flashing and testing phase. The value is saved in
non-volatile memory and will stay after a power cycle.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_display_driver(device::BrickletEPaper296x128, display_driver)
    device.deviceInternal.set_display_driver(display_driver)
end

export get_display_driver
"""
    $(SIGNATURES)

Returns the e-paper display driver.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_display_driver(device::BrickletEPaper296x128)
    return device.deviceInternal.get_display_driver()
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
function get_spitfp_error_count(device::BrickletEPaper296x128)
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
function set_bootloader_mode(device::BrickletEPaper296x128, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletEPaper296x128)
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
function set_write_firmware_pointer(device::BrickletEPaper296x128, pointer)
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
function write_firmware(device::BrickletEPaper296x128, data)
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
function set_status_led_config(device::BrickletEPaper296x128, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletEPaper296x128)
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
function get_chip_temperature(device::BrickletEPaper296x128)
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
function reset(device::BrickletEPaper296x128)
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
function write_uid(device::BrickletEPaper296x128, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletEPaper296x128)
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
function get_identity(device::BrickletEPaper296x128)
    return device.deviceInternal.get_identity()
end

export write_black_white
"""
Writes black/white pixels to the specified window into the buffer.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

The value 0 (false) corresponds to a black pixel and the value 1 (true) to a
white pixel.

This function writes the pixels into the black/white pixel buffer, to draw the
buffer to the display use :func:`Draw`.

Use :func:`Write Color` to write red or gray pixels.
"""
function write_black_white(device::BrickletEPaper296x128, x_start, y_start, x_end, y_end, pixels)

        x_start = UInt16(x_start)
    y_start = UInt8(y_start)
    x_end = UInt16(x_end)
    y_end = UInt8(y_end)
    pixels = convert(Vector{Bool}, pixels)

    if length(pixels) > 65535
        throw(TinkerforgeInvalidParameterError("Pixels can be at most 65535 items long"))
    end

    pixels_length = length(pixels)
    pixels_chunk_offset = 0

    if pixels_length == 0
        pixels_chunk_data = [False] * 432
        ret = write_black_white_low_level(device, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
    else
        lock(device.stream_lock) do
            while pixels_chunk_offset < pixels_length
                pixels_chunk_data = create_chunk_data(pixels, pixels_chunk_offset, 432, False)
                ret = write_black_white_low_level(device, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
                pixels_chunk_offset += 432
            end
        end
    end

        return ret
end

export read_black_white
"""
Returns the current content of the black/white pixel buffer for the specified window.

The pixels are read into the window line by line top to bottom and
each line is read from left to right.

The current content of the buffer does not have to be the current content of the display.
It is possible that the data was not drawn to the display yet and after a restart of
the Bricklet the buffer will be reset to black, while the display retains its content.
"""
function read_black_white(device::BrickletEPaper296x128, x_start, y_start, x_end, y_end)

        x_start = UInt16(x_start)
    y_start = UInt8(y_start)
    x_end = UInt16(x_end)
    y_end = UInt8(y_end)

    lock(device.stream_lock) do
        ret = read_black_white_low_level(device, x_start, y_start, x_end, y_end)
            pixels_length = ret.pixels_length
        pixels_out_of_sync = ret.pixels_chunk_offset != 0

        pixels_data = ret.pixels_chunk_data

        while !pixels_out_of_sync && length(pixels_data) < pixels_length
            ret = read_black_white_low_level(device, x_start, y_start, x_end, y_end)
                pixels_length = ret.pixels_length
            pixels_out_of_sync = ret.pixels_chunk_offset != length(pixels_data)
            pixels_data += ret.pixels_chunk_data
        end

        if pixels_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.pixels_chunk_offset + 464 < pixels_length
                ret = read_black_white_low_level(device, x_start, y_start, x_end, y_end)
                    pixels_length = ret.pixels_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Pixels stream is out-of-sync"))
        end
    end

        return pixels_data[:pixels_length]
end

export write_color
"""
The E-Paper 296x128 Bricklet is available with the colors black/white/red and
black/white/gray. Depending on the model this function writes either red or
gray pixels to the specified window into the buffer.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

The value 0 (false) means that this pixel does not have color. It will be either black
or white (see :func:`Write Black White`). The value 1 (true) corresponds to a red or gray
pixel, depending on the Bricklet model.

This function writes the pixels into the red or gray pixel buffer, to draw the buffer
to the display use :func:`Draw`.

Use :func:`Write Black White` to write black/white pixels.
"""
function write_color(device::BrickletEPaper296x128, x_start, y_start, x_end, y_end, pixels)

        x_start = UInt16(x_start)
    y_start = UInt8(y_start)
    x_end = UInt16(x_end)
    y_end = UInt8(y_end)
    pixels = convert(Vector{Bool}, pixels)

    if length(pixels) > 65535
        throw(TinkerforgeInvalidParameterError("Pixels can be at most 65535 items long"))
    end

    pixels_length = length(pixels)
    pixels_chunk_offset = 0

    if pixels_length == 0
        pixels_chunk_data = [False] * 432
        ret = write_color_low_level(device, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
    else
        lock(device.stream_lock) do
            while pixels_chunk_offset < pixels_length
                pixels_chunk_data = create_chunk_data(pixels, pixels_chunk_offset, 432, False)
                ret = write_color_low_level(device, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
                pixels_chunk_offset += 432
            end
        end
    end

        return ret
end

export read_color
"""
Returns the current content of the red or gray pixel buffer for the specified window.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

The current content of the buffer does not have to be the current content of the display.
It is possible that the data was not drawn to the display yet and after a restart of
the Bricklet the buffer will be reset to black, while the display retains its content.
"""
function read_color(device::BrickletEPaper296x128, x_start, y_start, x_end, y_end)

        x_start = UInt16(x_start)
    y_start = UInt8(y_start)
    x_end = UInt16(x_end)
    y_end = UInt8(y_end)

    lock(device.stream_lock) do
        ret = read_color_low_level(device, x_start, y_start, x_end, y_end)
            pixels_length = ret.pixels_length
        pixels_out_of_sync = ret.pixels_chunk_offset != 0

        pixels_data = ret.pixels_chunk_data

        while !pixels_out_of_sync && length(pixels_data) < pixels_length
            ret = read_color_low_level(device, x_start, y_start, x_end, y_end)
                pixels_length = ret.pixels_length
            pixels_out_of_sync = ret.pixels_chunk_offset != length(pixels_data)
            pixels_data += ret.pixels_chunk_data
        end

        if pixels_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.pixels_chunk_offset + 464 < pixels_length
                ret = read_color_low_level(device, x_start, y_start, x_end, y_end)
                    pixels_length = ret.pixels_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Pixels stream is out-of-sync"))
        end
    end

        return pixels_data[:pixels_length]
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletEPaper296x128, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
