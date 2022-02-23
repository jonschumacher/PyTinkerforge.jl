


export BrickletOLED128x64DisplayConfiguration
struct BrickletOLED128x64DisplayConfiguration
    contrast::Integer
    invert::Bool
end

export BrickletOLED128x64Identity
struct BrickletOLED128x64Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletOLED128x64
"""
3.3cm (1.3") OLED display with 128x64 pixels
"""
mutable struct BrickletOLED128x64 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletOLED128x64(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_oled_128x64")
        deviceInternal = package.BrickletOLED128x64(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write
"""
    $(SIGNATURES)

Appends 64 byte of data to the window as set by :func:`New Window`.

Each row has a height of 8 pixels which corresponds to one byte of data.

Example: if you call :func:`New Window` with column from 0 to 127 and row
from 0 to 7 (the whole display) each call of :func:`Write` (red arrow) will
write half of a row.

.. image:: /Images/Bricklets/bricklet_oled_128x64_display.png
   :scale: 100 %
   :alt: Display pixel order
   :align: center
   :target: ../../_images/Bricklets/bricklet_oled_128x64_display.png

The LSB (D0) of each data byte is at the top and the MSB (D7) is at the
bottom of the row.

The next call of :func:`Write` will write the second half of the row
and the next two the second row and so on. To fill the whole display
you need to call :func:`Write` 16 times.
"""
function write(device::BrickletOLED128x64, data)
    device.deviceInternal.write(data)
end

export new_window
"""
    $(SIGNATURES)

Sets the window in which you can write with :func:`Write`. One row
has a height of 8 pixels.
"""
function new_window(device::BrickletOLED128x64, column_from, column_to, row_from, row_to)
    device.deviceInternal.new_window(column_from, column_to, row_from, row_to)
end

export clear_display
"""
    $(SIGNATURES)

Clears the current content of the window as set by :func:`New Window`.
"""
function clear_display(device::BrickletOLED128x64)
    device.deviceInternal.clear_display()
end

export set_display_configuration
"""
    $(SIGNATURES)

Sets the configuration of the display.

You can set a contrast value from 0 to 255 and you can invert the color
(black/white) of the display.
"""
function set_display_configuration(device::BrickletOLED128x64, contrast, invert)
    device.deviceInternal.set_display_configuration(contrast, invert)
end

export get_display_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Display Configuration`.
"""
function get_display_configuration(device::BrickletOLED128x64)
    return device.deviceInternal.get_display_configuration()
end

export write_line
"""
    $(SIGNATURES)

Writes text to a specific line with a specific position.
The text can have a maximum of 26 characters.

For example: (1, 10, "Hello") will write *Hello* in the middle of the
second line of the display.

You can draw to the display with :func:`Write` and then add text to it
afterwards.

The display uses a special 5x7 pixel charset. You can view the characters
of the charset in Brick Viewer.
"""
function write_line(device::BrickletOLED128x64, line, position, text)
    device.deviceInternal.write_line(line, position, text)
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
function get_identity(device::BrickletOLED128x64)
    return device.deviceInternal.get_identity()
end
