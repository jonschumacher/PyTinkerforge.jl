


export BrickletPTCTemperatureCallbackThreshold
struct BrickletPTCTemperatureCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletPTCResistanceCallbackThreshold
struct BrickletPTCResistanceCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletPTCIdentity
struct BrickletPTCIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletPTC
"""
Reads temperatures from Pt100 und Pt1000 sensors
"""
mutable struct BrickletPTC <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletPTC(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_ptc")
        deviceInternal = package.BrickletPTC(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_temperature
"""
    $(SIGNATURES)

Returns the temperature of connected sensor.

If you want to get the temperature periodically, it is recommended
to use the :cb:`Temperature` callback and set the period with
:func:`Set Temperature Callback Period`.
"""
function get_temperature(device::BrickletPTC)
    return device.deviceInternal.get_temperature()
end

export get_resistance
"""
    $(SIGNATURES)

Returns the value as measured by the MAX31865 precision delta-sigma ADC.

The value can be converted with the following formulas:

* Pt100:  resistance = (value * 390) / 32768
* Pt1000: resistance = (value * 3900) / 32768

If you want to get the resistance periodically, it is recommended
to use the :cb:`Resistance` callback and set the period with
:func:`Set Resistance Callback Period`.
"""
function get_resistance(device::BrickletPTC)
    return device.deviceInternal.get_resistance()
end

export set_temperature_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Temperature` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Temperature` callback is only triggered if the temperature has
changed since the last triggering.
"""
function set_temperature_callback_period(device::BrickletPTC, period)
    device.deviceInternal.set_temperature_callback_period(period)
end

export get_temperature_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Temperature Callback Period`.
"""
function get_temperature_callback_period(device::BrickletPTC)
    return device.deviceInternal.get_temperature_callback_period()
end

export set_resistance_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Resistance` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Resistance` callback is only triggered if the resistance has changed
since the last triggering.
"""
function set_resistance_callback_period(device::BrickletPTC, period)
    device.deviceInternal.set_resistance_callback_period(period)
end

export get_resistance_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Resistance Callback Period`.
"""
function get_resistance_callback_period(device::BrickletPTC)
    return device.deviceInternal.get_resistance_callback_period()
end

export set_temperature_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Temperature Reached` callback.

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
function set_temperature_callback_threshold(device::BrickletPTC, option, min, max)
    device.deviceInternal.set_temperature_callback_threshold(option, min, max)
end

export get_temperature_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Temperature Callback Threshold`.
"""
function get_temperature_callback_threshold(device::BrickletPTC)
    return device.deviceInternal.get_temperature_callback_threshold()
end

export set_resistance_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Resistance Reached` callback.

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
function set_resistance_callback_threshold(device::BrickletPTC, option, min, max)
    device.deviceInternal.set_resistance_callback_threshold(option, min, max)
end

export get_resistance_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Resistance Callback Threshold`.
"""
function get_resistance_callback_threshold(device::BrickletPTC)
    return device.deviceInternal.get_resistance_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Temperature Reached`,
* :cb:`Resistance Reached`

is triggered, if the threshold

* :func:`Set Temperature Callback Threshold`,
* :func:`Set Resistance Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletPTC, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletPTC)
    return device.deviceInternal.get_debounce_period()
end

export set_noise_rejection_filter
"""
    $(SIGNATURES)

Sets the noise rejection filter to either 50Hz (0) or 60Hz (1).
Noise from 50Hz or 60Hz power sources (including
harmonics of the AC power's fundamental frequency) is
attenuated by 82dB.
"""
function set_noise_rejection_filter(device::BrickletPTC, filter)
    device.deviceInternal.set_noise_rejection_filter(filter)
end

export get_noise_rejection_filter
"""
    $(SIGNATURES)

Returns the noise rejection filter option as set by
:func:`Set Noise Rejection Filter`
"""
function get_noise_rejection_filter(device::BrickletPTC)
    return device.deviceInternal.get_noise_rejection_filter()
end

export is_sensor_connected
"""
    $(SIGNATURES)

Returns *true* if the sensor is connected correctly.

If this function
returns *false*, there is either no Pt100 or Pt1000 sensor connected,
the sensor is connected incorrectly or the sensor itself is faulty.
"""
function is_sensor_connected(device::BrickletPTC)
    return device.deviceInternal.is_sensor_connected()
end

export set_wire_mode
"""
    $(SIGNATURES)

Sets the wire mode of the sensor. Possible values are 2, 3 and 4 which
correspond to 2-, 3- and 4-wire sensors. The value has to match the jumper
configuration on the Bricklet.
"""
function set_wire_mode(device::BrickletPTC, mode)
    device.deviceInternal.set_wire_mode(mode)
end

export get_wire_mode
"""
    $(SIGNATURES)

Returns the wire mode as set by :func:`Set Wire Mode`
"""
function get_wire_mode(device::BrickletPTC)
    return device.deviceInternal.get_wire_mode()
end

export set_sensor_connected_callback_configuration
"""
    $(SIGNATURES)

If you enable this callback, the :cb:`Sensor Connected` callback is triggered
every time a Pt sensor is connected/disconnected.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_sensor_connected_callback_configuration(device::BrickletPTC, enabled)
    device.deviceInternal.set_sensor_connected_callback_configuration(enabled)
end

export get_sensor_connected_callback_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Sensor Connected Callback Configuration`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_sensor_connected_callback_configuration(device::BrickletPTC)
    return device.deviceInternal.get_sensor_connected_callback_configuration()
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
function get_identity(device::BrickletPTC)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletPTC, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
