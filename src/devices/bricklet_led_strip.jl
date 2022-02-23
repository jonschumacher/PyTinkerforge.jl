


export BrickletLEDStripRGBValues
struct BrickletLEDStripRGBValues
    r::Vector{Integer}
    g::Vector{Integer}
    b::Vector{Integer}
end

export BrickletLEDStripRGBWValues
struct BrickletLEDStripRGBWValues
    r::Vector{Integer}
    g::Vector{Integer}
    b::Vector{Integer}
    w::Vector{Integer}
end

export BrickletLEDStripIdentity
struct BrickletLEDStripIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletLEDStrip
"""
Controls up to 320 RGB LEDs
"""
mutable struct BrickletLEDStrip <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletLEDStrip(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_led_strip")
        deviceInternal = package.BrickletLEDStrip(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_rgb_values
"""
    $(SIGNATURES)

Sets *length* RGB values for the LEDs starting from *index*.

To make the colors show correctly you need to configure the chip type
(:func:`Set Chip Type`) and a 3-channel channel mapping (:func:`Set Channel Mapping`)
according to the connected LEDs.

Example: If you set

* index to 5,
* length to 3,
* r to [255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
* g to [0, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] and
* b to [0, 0, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

the LED with index 5 will be red, 6 will be green and 7 will be blue.

.. note:: Depending on the LED circuitry colors can be permuted.

The colors will be transfered to actual LEDs when the next
frame duration ends, see :func:`Set Frame Duration`.

Generic approach:

* Set the frame duration to a value that represents
  the number of frames per second you want to achieve.
* Set all of the LED colors for one frame.
* Wait for the :cb:`Frame Rendered` callback.
* Set all of the LED colors for next frame.
* Wait for the :cb:`Frame Rendered` callback.
* and so on.

This approach ensures that you can change the LED colors with
a fixed frame rate.

The actual number of controllable LEDs depends on the number of free
Bricklet ports. See :ref:`here <led_strip_bricklet_ram_constraints>` for more
information. A call of :func:`Set RGB Values` with index + length above the
bounds is ignored completely.
"""
function set_rgb_values(device::BrickletLEDStrip, index, length, r, g, b)
    device.deviceInternal.set_rgb_values(index, length, r, g, b)
end

export get_rgb_values
"""
    $(SIGNATURES)

Returns *length* R, G and B values starting from the
given LED *index*.

The values are the last values that were set by :func:`Set RGB Values`.
"""
function get_rgb_values(device::BrickletLEDStrip, index, length)
    return device.deviceInternal.get_rgb_values(index, length)
end

export set_frame_duration
"""
    $(SIGNATURES)

Sets the frame duration.

Example: If you want to achieve 20 frames per second, you should
set the frame duration to 50ms (50ms * 20 = 1 second).

For an explanation of the general approach see :func:`Set RGB Values`.
"""
function set_frame_duration(device::BrickletLEDStrip, duration)
    device.deviceInternal.set_frame_duration(duration)
end

export get_frame_duration
"""
    $(SIGNATURES)

Returns the frame duration as set by :func:`Set Frame Duration`.
"""
function get_frame_duration(device::BrickletLEDStrip)
    return device.deviceInternal.get_frame_duration()
end

export get_supply_voltage
"""
    $(SIGNATURES)

Returns the current supply voltage of the LEDs.
"""
function get_supply_voltage(device::BrickletLEDStrip)
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

.. note::
 The frequency in firmware version 2.0.0 is fixed at 2MHz.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_clock_frequency(device::BrickletLEDStrip, frequency)
    device.deviceInternal.set_clock_frequency(frequency)
end

export get_clock_frequency
"""
    $(SIGNATURES)

Returns the currently used clock frequency as set by :func:`Set Clock Frequency`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_clock_frequency(device::BrickletLEDStrip)
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
* LPD8806 and
* APA102 / DotStar.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_chip_type(device::BrickletLEDStrip, chip)
    device.deviceInternal.set_chip_type(chip)
end

export get_chip_type
"""
    $(SIGNATURES)

Returns the currently used chip type as set by :func:`Set Chip Type`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_chip_type(device::BrickletLEDStrip)
    return device.deviceInternal.get_chip_type()
end

export set_rgbw_values
"""
    $(SIGNATURES)

Sets *length* RGBW values for the LEDs starting from *index*.

To make the colors show correctly you need to configure the chip type
(:func:`Set Chip Type`) and a 4-channel channel mapping (:func:`Set Channel Mapping`)
according to the connected LEDs.

The maximum length is 12, the index goes from 0 to 239 and the rgbw values
have 8 bits each.

Example: If you set

* index to 5,
* length to 4,
* r to [255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
* g to [0, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
* b to [0, 0, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0] and
* w to [0, 0, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0]

the LED with index 5 will be red, 6 will be green, 7 will be blue and 8 will be white.

.. note:: Depending on the LED circuitry colors can be permuted.

The colors will be transfered to actual LEDs when the next
frame duration ends, see :func:`Set Frame Duration`.

Generic approach:

* Set the frame duration to a value that represents
  the number of frames per second you want to achieve.
* Set all of the LED colors for one frame.
* Wait for the :cb:`Frame Rendered` callback.
* Set all of the LED colors for next frame.
* Wait for the :cb:`Frame Rendered` callback.
* and so on.

This approach ensures that you can change the LED colors with
a fixed frame rate.

The actual number of controllable LEDs depends on the number of free
Bricklet ports. See :ref:`here <led_strip_bricklet_ram_constraints>` for more
information. A call of :func:`Set RGBW Values` with index + length above the
bounds is ignored completely.

The LPD8806 LED driver chips have 7-bit channels for RGB. Internally the LED
Strip Bricklets divides the 8-bit values set using this function by 2 to make
them 7-bit. Therefore, you can just use the normal value range (0-255) for
LPD8806 LEDs.

The brightness channel of the APA102 LED driver chips has 5-bit. Internally the
LED Strip Bricklets divides the 8-bit values set using this function by 8 to make
them 5-bit. Therefore, you can just use the normal value range (0-255) for
the brightness channel of APA102 LEDs.

.. versionadded:: 2.0.6\$nbsp;(Plugin)
"""
function set_rgbw_values(device::BrickletLEDStrip, index, length, r, g, b, w)
    device.deviceInternal.set_rgbw_values(index, length, r, g, b, w)
end

export get_rgbw_values
"""
    $(SIGNATURES)

Returns *length* RGBW values starting from the given *index*.

The values are the last values that were set by :func:`Set RGBW Values`.

.. versionadded:: 2.0.6\$nbsp;(Plugin)
"""
function get_rgbw_values(device::BrickletLEDStrip, index, length)
    return device.deviceInternal.get_rgbw_values(index, length)
end

export set_channel_mapping
"""
    $(SIGNATURES)

Sets the channel mapping for the connected LEDs.

:func:`Set RGB Values` and :func:`Set RGBW Values` take the data in RGB(W) order.
But the connected LED driver chips might have their 3 or 4 channels in a
different order. For example, the WS2801 chips typically use BGR order, the
WS2812 chips typically use GRB order and the APA102 chips typically use WBGR
order.

The APA102 chips are special. They have three 8-bit channels for RGB
and an additional 5-bit channel for the overall brightness of the RGB LED
making them 4-channel chips. Internally the brightness channel is the first
channel, therefore one of the Wxyz channel mappings should be used. Then
the W channel controls the brightness.

If a 3-channel mapping is selected then :func:`Set RGB Values` has to be used.
Calling :func:`Set RGBW Values` with a 3-channel mapping will produce incorrect
results. Vice-versa if a 4-channel mapping is selected then
:func:`Set RGBW Values` has to be used. Calling :func:`Set RGB Values` with a
4-channel mapping will produce incorrect results.

.. versionadded:: 2.0.6\$nbsp;(Plugin)
"""
function set_channel_mapping(device::BrickletLEDStrip, mapping)
    device.deviceInternal.set_channel_mapping(mapping)
end

export get_channel_mapping
"""
    $(SIGNATURES)

Returns the currently used channel mapping as set by :func:`Set Channel Mapping`.

.. versionadded:: 2.0.6\$nbsp;(Plugin)
"""
function get_channel_mapping(device::BrickletLEDStrip)
    return device.deviceInternal.get_channel_mapping()
end

export enable_frame_rendered_callback
"""
    $(SIGNATURES)

Enables the :cb:`Frame Rendered` callback.

By default the callback is enabled.

.. versionadded:: 2.0.6\$nbsp;(Plugin)
"""
function enable_frame_rendered_callback(device::BrickletLEDStrip)
    device.deviceInternal.enable_frame_rendered_callback()
end

export disable_frame_rendered_callback
"""
    $(SIGNATURES)

Disables the :cb:`Frame Rendered` callback.

By default the callback is enabled.

.. versionadded:: 2.0.6\$nbsp;(Plugin)
"""
function disable_frame_rendered_callback(device::BrickletLEDStrip)
    device.deviceInternal.disable_frame_rendered_callback()
end

export is_frame_rendered_callback_enabled
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Frame Rendered` callback is enabled, *false* otherwise.

.. versionadded:: 2.0.6\$nbsp;(Plugin)
"""
function is_frame_rendered_callback_enabled(device::BrickletLEDStrip)
    return device.deviceInternal.is_frame_rendered_callback_enabled()
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
function get_identity(device::BrickletLEDStrip)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletLEDStrip, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
