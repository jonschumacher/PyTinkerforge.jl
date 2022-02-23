


export BrickletIndustrialDual020mACurrentCallbackThreshold
struct BrickletIndustrialDual020mACurrentCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletIndustrialDual020mAIdentity
struct BrickletIndustrialDual020mAIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialDual020mA
"""
Measures two DC currents between 0mA and 20mA (IEC 60381-1)
"""
mutable struct BrickletIndustrialDual020mA <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialDual020mA(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_dual_0_20ma")
        deviceInternal = package.BrickletIndustrialDual020mA(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_current
"""
    $(SIGNATURES)

Returns the current of the specified sensor.

It is possible to detect if an IEC 60381-1 compatible sensor is connected
and if it works properly.

If the returned current is below 4mA, there is likely no sensor connected
or the sensor may be defect. If the returned current is over 20mA, there might
be a short circuit or the sensor may be defect.

If you want to get the current periodically, it is recommended to use the
:cb:`Current` callback and set the period with
:func:`Set Current Callback Period`.
"""
function get_current(device::BrickletIndustrialDual020mA, sensor)
    return device.deviceInternal.get_current(sensor)
end

export set_current_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Current` callback is triggered
periodically for the given sensor. A value of 0 turns the callback off.

The :cb:`Current` callback is only triggered if the current has changed since the
last triggering.
"""
function set_current_callback_period(device::BrickletIndustrialDual020mA, sensor, period)
    device.deviceInternal.set_current_callback_period(sensor, period)
end

export get_current_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Current Callback Period`.
"""
function get_current_callback_period(device::BrickletIndustrialDual020mA, sensor)
    return device.deviceInternal.get_current_callback_period(sensor)
end

export set_current_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Current Reached` callback for the given
sensor.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the current is *outside* the min and max values"
 "'i'",    "Callback is triggered when the current is *inside* the min and max values"
 "'<'",    "Callback is triggered when the current is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the current is greater than the min value (max is ignored)"
"""
function set_current_callback_threshold(device::BrickletIndustrialDual020mA, sensor, option, min, max)
    device.deviceInternal.set_current_callback_threshold(sensor, option, min, max)
end

export get_current_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Current Callback Threshold`.
"""
function get_current_callback_threshold(device::BrickletIndustrialDual020mA, sensor)
    return device.deviceInternal.get_current_callback_threshold(sensor)
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Current Reached`

is triggered, if the threshold

* :func:`Set Current Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletIndustrialDual020mA, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletIndustrialDual020mA)
    return device.deviceInternal.get_debounce_period()
end

export set_sample_rate
"""
    $(SIGNATURES)

Sets the sample rate to either 240, 60, 15 or 4 samples per second.
The resolution for the rates is 12, 14, 16 and 18 bit respectively.

.. csv-table::
 :header: "Value", "Description"
 :widths: 10, 100

 "0",    "240 samples per second, 12 bit resolution"
 "1",    "60 samples per second, 14 bit resolution"
 "2",    "15 samples per second, 16 bit resolution"
 "3",    "4 samples per second, 18 bit resolution"
"""
function set_sample_rate(device::BrickletIndustrialDual020mA, rate)
    device.deviceInternal.set_sample_rate(rate)
end

export get_sample_rate
"""
    $(SIGNATURES)

Returns the sample rate as set by :func:`Set Sample Rate`.
"""
function get_sample_rate(device::BrickletIndustrialDual020mA)
    return device.deviceInternal.get_sample_rate()
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
function get_identity(device::BrickletIndustrialDual020mA)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIndustrialDual020mA, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
