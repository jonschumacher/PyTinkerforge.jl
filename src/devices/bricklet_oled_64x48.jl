


export BrickletOLED64x48DisplayConfiguration
struct BrickletOLED64x48DisplayConfiguration
    contrast::Integer
    invert::Bool
end

export BrickletOLED64x48Identity
struct BrickletOLED64x48Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletOLED64x48
"""
1.68cm (0.66") OLED display with 64x48 pixels
"""
mutable struct BrickletOLED64x48 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletOLED64x48(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_oled_64x48")
        deviceInternal = package.BrickletOLED64x48(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write
"""
    $(SIGNATURES)

Appends 64 byte of data to the window as set by :func:`New Window`.

Each row has a height of 8 pixels which corresponds to one byte of data.

Example: if you call :func:`New Window` with column from 0 to 63 and row
from 0 to 5 (the whole display) each call of :func:`Write` (red arrow) will
write one row.

.. image:: /Images/Bricklets/bricklet_oled_64x48_display.png
   :scale: 100 %
   :alt: Display pixel order
   :align: center
   :target: ../../_images/Bricklets/bricklet_oled_64x48_display.png

The LSB (D0) of each data byte is at the top and the MSB (D7) is at the
bottom of the row.

The next call of :func:`Write` will write the second row and so on. To
fill the whole display you need to call :func:`Write` 6 times.
"""
function write(device::BrickletOLED64x48, data)
    device.deviceInternal.write(data)
end

export new_window
"""
    $(SIGNATURES)

Sets the window in which you can write with :func:`Write`. One row
has a height of 8 pixels.
"""
function new_window(device::BrickletOLED64x48, column_from, column_to, row_from, row_to)
    device.deviceInternal.new_window(column_from, column_to, row_from, row_to)
end

export clear_display
"""
    $(SIGNATURES)

Clears the current content of the window as set by :func:`New Window`.
"""
function clear_display(device::BrickletOLED64x48)
    device.deviceInternal.clear_display()
end

export set_display_configuration
"""
    $(SIGNATURES)

Sets the configuration of the display.

You can set a contrast value from 0 to 255 and you can invert the color
(black/white) of the display.
"""
function set_display_configuration(device::BrickletOLED64x48, contrast, invert)
    device.deviceInternal.set_display_configuration(contrast, invert)
end

export get_display_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Display Configuration`.
"""
function get_display_configuration(device::BrickletOLED64x48)
    return device.deviceInternal.get_display_configuration()
end

export write_line
"""
    $(SIGNATURES)

Writes text to a specific line with a specific position.
The text can have a maximum of 13 characters.

For example: (1, 4, "Hello") will write *Hello* in the middle of the
second line of the display.

You can draw to the display with :func:`Write` and then add text to it
afterwards.

The display uses a special 5x7 pixel charset. You can view the characters
of the charset in Brick Viewer.
"""
function write_line(device::BrickletOLED64x48, line, position, text)
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
function get_identity(device::BrickletOLED64x48)
    return device.deviceInternal.get_identity()
end
