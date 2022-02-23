


export BrickletLCD16x2Config
struct BrickletLCD16x2Config
    cursor::Bool
    blinking::Bool
end

export BrickletLCD16x2Identity
struct BrickletLCD16x2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletLCD16x2
"""
16x2 character alphanumeric display with blue backlight
"""
mutable struct BrickletLCD16x2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletLCD16x2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_lcd_16x2")
        deviceInternal = package.BrickletLCD16x2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write_line
"""
    $(SIGNATURES)

Writes text to a specific line with a specific position.
The text can have a maximum of 16 characters.

For example: (0, 5, "Hello") will write *Hello* in the middle of the
first line of the display.

The display uses a special charset that includes all ASCII characters except
backslash and tilde. The LCD charset also includes several other non-ASCII characters, see
the `charset specification <https://github.com/Tinkerforge/lcd-16x2-bricklet/raw/master/datasheets/standard_charset.pdf>`__
for details. The Unicode example above shows how to specify non-ASCII characters
and how to translate from Unicode to the LCD charset.
"""
function write_line(device::BrickletLCD16x2, line, position, text)
    device.deviceInternal.write_line(line, position, text)
end

export clear_display
"""
    $(SIGNATURES)

Deletes all characters from the display.
"""
function clear_display(device::BrickletLCD16x2)
    device.deviceInternal.clear_display()
end

export backlight_on
"""
    $(SIGNATURES)

Turns the backlight on.
"""
function backlight_on(device::BrickletLCD16x2)
    device.deviceInternal.backlight_on()
end

export backlight_off
"""
    $(SIGNATURES)

Turns the backlight off.
"""
function backlight_off(device::BrickletLCD16x2)
    device.deviceInternal.backlight_off()
end

export is_backlight_on
"""
    $(SIGNATURES)

Returns *true* if the backlight is on and *false* otherwise.
"""
function is_backlight_on(device::BrickletLCD16x2)
    return device.deviceInternal.is_backlight_on()
end

export set_config
"""
    $(SIGNATURES)

Configures if the cursor (shown as "_") should be visible and if it
should be blinking (shown as a blinking block). The cursor position
is one character behind the the last text written with
:func:`Write Line`.
"""
function set_config(device::BrickletLCD16x2, cursor, blinking)
    device.deviceInternal.set_config(cursor, blinking)
end

export get_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Config`.
"""
function get_config(device::BrickletLCD16x2)
    return device.deviceInternal.get_config()
end

export is_button_pressed
"""
    $(SIGNATURES)

Returns *true* if the button is pressed.

If you want to react on button presses and releases it is recommended to use the
:cb:`Button Pressed` and :cb:`Button Released` callbacks.
"""
function is_button_pressed(device::BrickletLCD16x2, button)
    return device.deviceInternal.is_button_pressed(button)
end

export set_custom_character
"""
    $(SIGNATURES)

The LCD 16x2 Bricklet can store up to 8 custom characters. The characters
consist of 5x8 pixels and can be addressed with the index 0-7. To describe
the pixels, the first 5 bits of 8 bytes are used. For example, to make
a custom character "H", you should transfer the following:

* ``character[0] = 0b00010001`` (decimal value 17)
* ``character[1] = 0b00010001`` (decimal value 17)
* ``character[2] = 0b00010001`` (decimal value 17)
* ``character[3] = 0b00011111`` (decimal value 31)
* ``character[4] = 0b00010001`` (decimal value 17)
* ``character[5] = 0b00010001`` (decimal value 17)
* ``character[6] = 0b00010001`` (decimal value 17)
* ``character[7] = 0b00000000`` (decimal value 0)

The characters can later be written with :func:`Write Line` by using the
characters with the byte representation 8 ("\\\\x08" or "\\\\u0008") to 15
("\\\\x0F" or "\\\\u000F").

You can play around with the custom characters in Brick Viewer since
version 2.0.1.

Custom characters are stored by the LCD in RAM, so they have to be set
after each startup.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_custom_character(device::BrickletLCD16x2, index, character)
    device.deviceInternal.set_custom_character(index, character)
end

export get_custom_character
"""
    $(SIGNATURES)

Returns the custom character for a given index, as set with
:func:`Set Custom Character`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_custom_character(device::BrickletLCD16x2, index)
    return device.deviceInternal.get_custom_character(index)
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
function get_identity(device::BrickletLCD16x2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletLCD16x2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
