


export BrickletMoistureMoistureCallbackThreshold
struct BrickletMoistureMoistureCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletMoistureIdentity
struct BrickletMoistureIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletMoisture
"""
Measures soil moisture
"""
mutable struct BrickletMoisture <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletMoisture(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_moisture")
        deviceInternal = package.BrickletMoisture(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_moisture_value
"""
    $(SIGNATURES)

Returns the current moisture value.
A small value corresponds to little moisture, a big
value corresponds to much moisture.

If you want to get the moisture value periodically, it is recommended
to use the :cb:`Moisture` callback and set the period with
:func:`Set Moisture Callback Period`.
"""
function get_moisture_value(device::BrickletMoisture)
    return device.deviceInternal.get_moisture_value()
end

export set_moisture_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Moisture` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Moisture` callback is only triggered if the moisture value has changed
since the last triggering.
"""
function set_moisture_callback_period(device::BrickletMoisture, period)
    device.deviceInternal.set_moisture_callback_period(period)
end

export get_moisture_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Moisture Callback Period`.
"""
function get_moisture_callback_period(device::BrickletMoisture)
    return device.deviceInternal.get_moisture_callback_period()
end

export set_moisture_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Moisture Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the moisture value is *outside* the min and max values"
 "'i'",    "Callback is triggered when the moisture value is *inside* the min and max values"
 "'<'",    "Callback is triggered when the moisture value is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the moisture value is greater than the min value (max is ignored)"
"""
function set_moisture_callback_threshold(device::BrickletMoisture, option, min, max)
    device.deviceInternal.set_moisture_callback_threshold(option, min, max)
end

export get_moisture_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Moisture Callback Threshold`.
"""
function get_moisture_callback_threshold(device::BrickletMoisture)
    return device.deviceInternal.get_moisture_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Moisture Reached`

is triggered, if the threshold

* :func:`Set Moisture Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletMoisture, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletMoisture)
    return device.deviceInternal.get_debounce_period()
end

export set_moving_average
"""
    $(SIGNATURES)

Sets the length of a `moving averaging <https://en.wikipedia.org/wiki/Moving_average>`__
for the moisture value.

Setting the length to 0 will turn the averaging completely off. With less
averaging, there is more noise on the data.
"""
function set_moving_average(device::BrickletMoisture, average)
    device.deviceInternal.set_moving_average(average)
end

export get_moving_average
"""
    $(SIGNATURES)

Returns the length moving average as set by :func:`Set Moving Average`.
"""
function get_moving_average(device::BrickletMoisture)
    return device.deviceInternal.get_moving_average()
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
function get_identity(device::BrickletMoisture)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletMoisture, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
