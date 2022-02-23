


export BrickletLCD20x4Config
struct BrickletLCD20x4Config
    cursor::Bool
    blinking::Bool
end

export BrickletLCD20x4Identity
struct BrickletLCD20x4Identity
    uid::String
    connected_uid::String
    position::String
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletLCD20x4
"""
20x4 character alphanumeric display with blue backlight
"""
mutable struct BrickletLCD20x4 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletLCD20x4(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_lcd_20x4")
        deviceInternal = package.BrickletLCD20x4(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write_line
"""
    $(SIGNATURES)

Writes text to a specific line with a specific position.
The text can have a maximum of 20 characters.

For example: (0, 7, "Hello") will write *Hello* in the middle of the
first line of the display.

The display uses a special charset that includes all ASCII characters except
backslash and tilde. The LCD charset also includes several other non-ASCII characters, see
the `charset specification <https://github.com/Tinkerforge/lcd-20x4-bricklet/raw/master/datasheets/standard_charset.pdf>`__
for details. The Unicode example above shows how to specify non-ASCII characters
and how to translate from Unicode to the LCD charset.
"""
function write_line(device::BrickletLCD20x4, line, position, text)
    device.deviceInternal.write_line(line, position, text)
end

export clear_display
"""
    $(SIGNATURES)

Deletes all characters from the display.
"""
function clear_display(device::BrickletLCD20x4)
    device.deviceInternal.clear_display()
end

export backlight_on
"""
    $(SIGNATURES)

Turns the backlight on.
"""
function backlight_on(device::BrickletLCD20x4)
    device.deviceInternal.backlight_on()
end

export backlight_off
"""
    $(SIGNATURES)

Turns the backlight off.
"""
function backlight_off(device::BrickletLCD20x4)
    device.deviceInternal.backlight_off()
end

export is_backlight_on
"""
    $(SIGNATURES)

Returns *true* if the backlight is on and *false* otherwise.
"""
function is_backlight_on(device::BrickletLCD20x4)
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
function set_config(device::BrickletLCD20x4, cursor, blinking)
    device.deviceInternal.set_config(cursor, blinking)
end

export get_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Config`.
"""
function get_config(device::BrickletLCD20x4)
    return device.deviceInternal.get_config()
end

export is_button_pressed
"""
    $(SIGNATURES)

Returns *true* if the button (0 to 2 or 0 to 3 since hardware version 1.2)
is pressed.

If you want to react on button presses and releases it is recommended to use
the :cb:`Button Pressed` and :cb:`Button Released` callbacks.
"""
function is_button_pressed(device::BrickletLCD20x4, button)
    return device.deviceInternal.is_button_pressed(button)
end

export set_custom_character
"""
    $(SIGNATURES)

The LCD 20x4 Bricklet can store up to 8 custom characters. The characters
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

You can play around with the custom characters in Brick Viewer version
since 2.0.1.

Custom characters are stored by the LCD in RAM, so they have to be set
after each startup.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_custom_character(device::BrickletLCD20x4, index, character)
    device.deviceInternal.set_custom_character(index, character)
end

export get_custom_character
"""
    $(SIGNATURES)

Returns the custom character for a given index, as set with
:func:`Set Custom Character`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_custom_character(device::BrickletLCD20x4, index)
    return device.deviceInternal.get_custom_character(index)
end

export set_default_text
"""
    $(SIGNATURES)

Sets the default text for lines 0-3. The max number of characters
per line is 20.

The default text is shown on the LCD, if the default text counter
expires, see :func:`Set Default Text Counter`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_default_text(device::BrickletLCD20x4, line, text)
    device.deviceInternal.set_default_text(line, text)
end

export get_default_text
"""
    $(SIGNATURES)

Returns the default text for a given line (0-3) as set by
:func:`Set Default Text`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_default_text(device::BrickletLCD20x4, line)
    return device.deviceInternal.get_default_text(line)
end

export set_default_text_counter
"""
    $(SIGNATURES)

Sets the default text counter. This counter is decremented each
ms by the LCD firmware. If the counter reaches 0, the default text
(see :func:`Set Default Text`) is shown on the LCD.

This functionality can be used to show a default text if the controlling
program crashes or the connection is interrupted.

A possible approach is to call :func:`Set Default Text Counter` every
minute with the parameter 1000*60*2 (2 minutes). In this case the
default text will be shown no later than 2 minutes after the
controlling program crashes.

A negative counter turns the default text functionality off.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_default_text_counter(device::BrickletLCD20x4, counter)
    device.deviceInternal.set_default_text_counter(counter)
end

export get_default_text_counter
"""
    $(SIGNATURES)

Returns the current value of the default text counter.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_default_text_counter(device::BrickletLCD20x4)
    return device.deviceInternal.get_default_text_counter()
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
function get_identity(device::BrickletLCD20x4)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
register_callback(device::BrickletLCD20x4, callback_id, function_) = device.deviceInternal.register_callback(callback_id, function_)
