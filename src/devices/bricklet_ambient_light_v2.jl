


export BrickletAmbientLightV2IlluminanceCallbackThreshold
struct BrickletAmbientLightV2IlluminanceCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletAmbientLightV2Configuration
struct BrickletAmbientLightV2Configuration
    illuminance_range::Integer
    integration_time::Integer
end

export BrickletAmbientLightV2Identity
struct BrickletAmbientLightV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAmbientLightV2
"""
Measures ambient light up to 64000lux
"""
mutable struct BrickletAmbientLightV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAmbientLightV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_ambient_light_v2")
        deviceInternal = package.BrickletAmbientLightV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_illuminance
"""
    $(SIGNATURES)

Returns the illuminance of the ambient light sensor. The measurement range goes
up to about 100000lux, but above 64000lux the precision starts to drop.

.. versionchanged:: 2.0.2\$nbsp;(Plugin)
  An illuminance of 0lux indicates an error condition where the sensor cannot
  perform a reasonable measurement. This can happen with very dim or very bright
  light conditions. In bright light conditions this might indicate that the sensor
  is saturated and the configuration should be modified (:func:`Set Configuration`)
  to better match the light conditions.

If you want to get the illuminance periodically, it is recommended to use the
:cb:`Illuminance` callback and set the period with
:func:`Set Illuminance Callback Period`.
"""
function get_illuminance(device::BrickletAmbientLightV2)
    return device.deviceInternal.get_illuminance()
end

export set_illuminance_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Illuminance` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Illuminance` callback is only triggered if the illuminance has changed
since the last triggering.
"""
function set_illuminance_callback_period(device::BrickletAmbientLightV2, period)
    device.deviceInternal.set_illuminance_callback_period(period)
end

export get_illuminance_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Illuminance Callback Period`.
"""
function get_illuminance_callback_period(device::BrickletAmbientLightV2)
    return device.deviceInternal.get_illuminance_callback_period()
end

export set_illuminance_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Illuminance Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the illuminance is *outside* the min and max values"
 "'i'",    "Callback is triggered when the illuminance is *inside* the min and max values"
 "'<'",    "Callback is triggered when the illuminance is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the illuminance is greater than the min value (max is ignored)"
"""
function set_illuminance_callback_threshold(device::BrickletAmbientLightV2, option, min, max)
    device.deviceInternal.set_illuminance_callback_threshold(option, min, max)
end

export get_illuminance_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Illuminance Callback Threshold`.
"""
function get_illuminance_callback_threshold(device::BrickletAmbientLightV2)
    return device.deviceInternal.get_illuminance_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Illuminance Reached`,

are triggered, if the thresholds

* :func:`Set Illuminance Callback Threshold`,

keep being reached.
"""
function set_debounce_period(device::BrickletAmbientLightV2, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletAmbientLightV2)
    return device.deviceInternal.get_debounce_period()
end

export set_configuration
"""
    $(SIGNATURES)

Sets the configuration. It is possible to configure an illuminance range
between 0-600lux and 0-64000lux and an integration time between 50ms and 400ms.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
  The unlimited illuminance range allows to measure up to about 100000lux, but
  above 64000lux the precision starts to drop.

A smaller illuminance range increases the resolution of the data. A longer
integration time will result in less noise on the data.

.. versionchanged:: 2.0.2\$nbsp;(Plugin)
  If the actual measure illuminance is out-of-range then the current illuminance
  range maximum +0.01lux is reported by :func:`Get Illuminance` and the
  :cb:`Illuminance` callback. For example, 800001 for the 0-8000lux range.

.. versionchanged:: 2.0.2\$nbsp;(Plugin)
  With a long integration time the sensor might be saturated before the measured
  value reaches the maximum of the selected illuminance range. In this case 0lux
  is reported by :func:`Get Illuminance` and the :cb:`Illuminance` callback.

If the measurement is out-of-range or the sensor is saturated then you should
configure the next higher illuminance range. If the highest range is already
in use, then start to reduce the integration time.
"""
function set_configuration(device::BrickletAmbientLightV2, illuminance_range, integration_time)
    device.deviceInternal.set_configuration(illuminance_range, integration_time)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletAmbientLightV2)
    return device.deviceInternal.get_configuration()
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
function get_identity(device::BrickletAmbientLightV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletAmbientLightV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
