


export BrickletCurrent25CurrentCallbackThreshold
struct BrickletCurrent25CurrentCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletCurrent25AnalogValueCallbackThreshold
struct BrickletCurrent25AnalogValueCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletCurrent25Identity
struct BrickletCurrent25Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletCurrent25
"""
Measures AC/DC current between -25A and +25A
"""
mutable struct BrickletCurrent25 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletCurrent25(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_current25")
        deviceInternal = package.BrickletCurrent25(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_current
"""
    $(SIGNATURES)

Returns the current of the sensor.

If you want to get the current periodically, it is recommended to use the
:cb:`Current` callback and set the period with
:func:`Set Current Callback Period`.
"""
function get_current(device::BrickletCurrent25)
    return device.deviceInternal.get_current()
end

export calibrate
"""
    $(SIGNATURES)

Calibrates the 0 value of the sensor. You have to call this function
when there is no current present.

The zero point of the current sensor
is depending on the exact properties of the analog-to-digital converter,
the length of the Bricklet cable and the temperature. Thus, if you change
the Brick or the environment in which the Bricklet is used, you might
have to recalibrate.

The resulting calibration will be saved on the EEPROM of the Current
Bricklet.
"""
function calibrate(device::BrickletCurrent25)
    device.deviceInternal.calibrate()
end

export is_over_current
"""
    $(SIGNATURES)

Returns *true* if more than 25A were measured.

.. note::
 To reset this value you have to power cycle the Bricklet.
"""
function is_over_current(device::BrickletCurrent25)
    return device.deviceInternal.is_over_current()
end

export get_analog_value
"""
    $(SIGNATURES)

Returns the value as read by a 12-bit analog-to-digital converter.

.. note::
 The value returned by :func:`Get Current` is averaged over several samples
 to yield less noise, while :func:`Get Analog Value` gives back raw
 unfiltered analog values. The only reason to use :func:`Get Analog Value` is,
 if you need the full resolution of the analog-to-digital converter.

If you want the analog value periodically, it is recommended to use the
:cb:`Analog Value` callback and set the period with
:func:`Set Analog Value Callback Period`.
"""
function get_analog_value(device::BrickletCurrent25)
    return device.deviceInternal.get_analog_value()
end

export set_current_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Current` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Current` callback is only triggered if the current has changed since
the last triggering.
"""
function set_current_callback_period(device::BrickletCurrent25, period)
    device.deviceInternal.set_current_callback_period(period)
end

export get_current_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Current Callback Period`.
"""
function get_current_callback_period(device::BrickletCurrent25)
    return device.deviceInternal.get_current_callback_period()
end

export set_analog_value_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Analog Value` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Analog Value` callback is only triggered if the analog value has
changed since the last triggering.
"""
function set_analog_value_callback_period(device::BrickletCurrent25, period)
    device.deviceInternal.set_analog_value_callback_period(period)
end

export get_analog_value_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Analog Value Callback Period`.
"""
function get_analog_value_callback_period(device::BrickletCurrent25)
    return device.deviceInternal.get_analog_value_callback_period()
end

export set_current_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Current Reached` callback.

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
function set_current_callback_threshold(device::BrickletCurrent25, option, min, max)
    device.deviceInternal.set_current_callback_threshold(option, min, max)
end

export get_current_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Current Callback Threshold`.
"""
function get_current_callback_threshold(device::BrickletCurrent25)
    return device.deviceInternal.get_current_callback_threshold()
end

export set_analog_value_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Analog Value Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the analog value is *outside* the min and max values"
 "'i'",    "Callback is triggered when the analog value is *inside* the min and max values"
 "'<'",    "Callback is triggered when the analog value is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the analog value is greater than the min value (max is ignored)"
"""
function set_analog_value_callback_threshold(device::BrickletCurrent25, option, min, max)
    device.deviceInternal.set_analog_value_callback_threshold(option, min, max)
end

export get_analog_value_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Analog Value Callback Threshold`.
"""
function get_analog_value_callback_threshold(device::BrickletCurrent25)
    return device.deviceInternal.get_analog_value_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Current Reached`,
* :cb:`Analog Value Reached`

are triggered, if the thresholds

* :func:`Set Current Callback Threshold`,
* :func:`Set Analog Value Callback Threshold`

keep being reached.
"""
function set_debounce_period(device::BrickletCurrent25, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletCurrent25)
    return device.deviceInternal.get_debounce_period()
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
function get_identity(device::BrickletCurrent25)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletCurrent25, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
