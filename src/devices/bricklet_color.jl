


export BrickletColorColor
struct BrickletColorColor
    r::Integer
    g::Integer
    b::Integer
    c::Integer
end

export BrickletColorColorCallbackThreshold
struct BrickletColorColorCallbackThreshold
    option::Char
    min_r::Integer
    max_r::Integer
    min_g::Integer
    max_g::Integer
    min_b::Integer
    max_b::Integer
    min_c::Integer
    max_c::Integer
end

export BrickletColorConfig
struct BrickletColorConfig
    gain::Integer
    integration_time::Integer
end

export BrickletColorIdentity
struct BrickletColorIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletColor
"""
Measures color (RGB value), illuminance and color temperature
"""
mutable struct BrickletColor <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletColor(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_color")
        deviceInternal = package.BrickletColor(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_color
"""
    $(SIGNATURES)

Returns the measured color of the sensor.

The red (r), green (g), blue (b) and clear (c) colors are measured
with four different photodiodes that are responsive at different
wavelengths:

.. image:: /Images/Bricklets/bricklet_color_wavelength_chart_600.jpg
   :scale: 100 %
   :alt: Chart Responsivity / Wavelength
   :align: center
   :target: ../../_images/Bricklets/bricklet_color_wavelength_chart_600.jpg

If you want to get the color periodically, it is recommended
to use the :cb:`Color` callback and set the period with
:func:`Set Color Callback Period`.
"""
function get_color(device::BrickletColor)
    return device.deviceInternal.get_color()
end

export set_color_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Color` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Color` callback is only triggered if the color has changed since the
last triggering.
"""
function set_color_callback_period(device::BrickletColor, period)
    device.deviceInternal.set_color_callback_period(period)
end

export get_color_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Color Callback Period`.
"""
function get_color_callback_period(device::BrickletColor)
    return device.deviceInternal.get_color_callback_period()
end

export set_color_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Color Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the temperature is *outside* the min and max values"
 "'i'",    "Callback is triggered when the temperature is *inside* the min and max values"
 "'<'",    "Callback is triggered when the temperature is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the temperature is greater than the min value (max is ignored)"
"""
function set_color_callback_threshold(device::BrickletColor, option, min_r, max_r, min_g, max_g, min_b, max_b, min_c, max_c)
    device.deviceInternal.set_color_callback_threshold(option, min_r, max_r, min_g, max_g, min_b, max_b, min_c, max_c)
end

export get_color_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Color Callback Threshold`.
"""
function get_color_callback_threshold(device::BrickletColor)
    return device.deviceInternal.get_color_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Color Reached`

is triggered, if the threshold

* :func:`Set Color Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletColor, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletColor)
    return device.deviceInternal.get_debounce_period()
end

export light_on
"""
    $(SIGNATURES)

Turns the LED on.
"""
function light_on(device::BrickletColor)
    device.deviceInternal.light_on()
end

export light_off
"""
    $(SIGNATURES)

Turns the LED off.
"""
function light_off(device::BrickletColor)
    device.deviceInternal.light_off()
end

export is_light_on
"""
    $(SIGNATURES)

Returns the state of the LED. Possible values are:

* 0: On
* 1: Off
"""
function is_light_on(device::BrickletColor)
    return device.deviceInternal.is_light_on()
end

export set_config
"""
    $(SIGNATURES)

Sets the configuration of the sensor. Gain and integration time
can be configured in this way.

For configuring the gain:

* 0: 1x Gain
* 1: 4x Gain
* 2: 16x Gain
* 3: 60x Gain

For configuring the integration time:

* 0: 2.4ms
* 1: 24ms
* 2: 101ms
* 3: 154ms
* 4: 700ms

Increasing the gain enables the sensor to detect a
color from a higher distance.

The integration time provides a trade-off between conversion time
and accuracy. With a longer integration time the values read will
be more accurate but it will take longer time to get the conversion
results.
"""
function set_config(device::BrickletColor, gain, integration_time)
    device.deviceInternal.set_config(gain, integration_time)
end

export get_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Config`.
"""
function get_config(device::BrickletColor)
    return device.deviceInternal.get_config()
end

export get_illuminance
"""
    $(SIGNATURES)

Returns the illuminance affected by the gain and integration time as
set by :func:`Set Config`. To get the illuminance in Lux apply this formula::

 lux = illuminance * 700 / gain / integration_time

To get a correct illuminance measurement make sure that the color
values themselves are not saturated. The color value (R, G or B)
is saturated if it is equal to the maximum value of 65535.
In that case you have to reduce the gain, see :func:`Set Config`.
"""
function get_illuminance(device::BrickletColor)
    return device.deviceInternal.get_illuminance()
end

export get_color_temperature
"""
    $(SIGNATURES)

Returns the color temperature.

To get a correct color temperature measurement make sure that the color
values themselves are not saturated. The color value (R, G or B)
is saturated if it is equal to the maximum value of 65535.
In that case you have to reduce the gain, see :func:`Set Config`.
"""
function get_color_temperature(device::BrickletColor)
    return device.deviceInternal.get_color_temperature()
end

export set_illuminance_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Illuminance` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Illuminance` callback is only triggered if the illuminance has changed
since the last triggering.
"""
function set_illuminance_callback_period(device::BrickletColor, period)
    device.deviceInternal.set_illuminance_callback_period(period)
end

export get_illuminance_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Illuminance Callback Period`.
"""
function get_illuminance_callback_period(device::BrickletColor)
    return device.deviceInternal.get_illuminance_callback_period()
end

export set_color_temperature_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Color Temperature` callback is
triggered periodically. A value of 0 turns the callback off.

The :cb:`Color Temperature` callback is only triggered if the color temperature
has changed since the last triggering.
"""
function set_color_temperature_callback_period(device::BrickletColor, period)
    device.deviceInternal.set_color_temperature_callback_period(period)
end

export get_color_temperature_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Color Temperature Callback Period`.
"""
function get_color_temperature_callback_period(device::BrickletColor)
    return device.deviceInternal.get_color_temperature_callback_period()
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
function get_identity(device::BrickletColor)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletColor, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
