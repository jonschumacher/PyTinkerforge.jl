


export BrickletJoystickPosition
struct BrickletJoystickPosition
    x::Integer
    y::Integer
end

export BrickletJoystickAnalogValue
struct BrickletJoystickAnalogValue
    x::Integer
    y::Integer
end

export BrickletJoystickPositionCallbackThreshold
struct BrickletJoystickPositionCallbackThreshold
    option::Char
    min_x::Integer
    max_x::Integer
    min_y::Integer
    max_y::Integer
end

export BrickletJoystickAnalogValueCallbackThreshold
struct BrickletJoystickAnalogValueCallbackThreshold
    option::Char
    min_x::Integer
    max_x::Integer
    min_y::Integer
    max_y::Integer
end

export BrickletJoystickIdentity
struct BrickletJoystickIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletJoystick
"""
2-axis joystick with push-button
"""
mutable struct BrickletJoystick <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletJoystick(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_joystick")
        deviceInternal = package.BrickletJoystick(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_position
"""
    $(SIGNATURES)

Returns the position of the joystick. The middle position of the joystick is x=0, y=0.
The returned values are averaged and calibrated (see :func:`Calibrate`).

If you want to get the position periodically, it is recommended to use the
:cb:`Position` callback and set the period with
:func:`Set Position Callback Period`.
"""
function get_position(device::BrickletJoystick)
    return device.deviceInternal.get_position()
end

export is_pressed
"""
    $(SIGNATURES)

Returns *true* if the button is pressed and *false* otherwise.

It is recommended to use the :cb:`Pressed` and :cb:`Released` callbacks
to handle the button.
"""
function is_pressed(device::BrickletJoystick)
    return device.deviceInternal.is_pressed()
end

export get_analog_value
"""
    $(SIGNATURES)

Returns the values as read by a 12-bit analog-to-digital converter.

.. note::
 The values returned by :func:`Get Position` are averaged over several samples
 to yield less noise, while :func:`Get Analog Value` gives back raw
 unfiltered analog values. The only reason to use :func:`Get Analog Value` is,
 if you need the full resolution of the analog-to-digital converter.

If you want the analog values periodically, it is recommended to use the
:cb:`Analog Value` callback and set the period with
:func:`Set Analog Value Callback Period`.
"""
function get_analog_value(device::BrickletJoystick)
    return device.deviceInternal.get_analog_value()
end

export calibrate
"""
    $(SIGNATURES)

Calibrates the middle position of the joystick. If your Joystick Bricklet
does not return x=0 and y=0 in the middle position, call this function
while the joystick is standing still in the middle position.

The resulting calibration will be saved on the EEPROM of the Joystick
Bricklet, thus you only have to calibrate it once.
"""
function calibrate(device::BrickletJoystick)
    device.deviceInternal.calibrate()
end

export set_position_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Position` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Position` callback is only triggered if the position has changed since the
last triggering.
"""
function set_position_callback_period(device::BrickletJoystick, period)
    device.deviceInternal.set_position_callback_period(period)
end

export get_position_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Position Callback Period`.
"""
function get_position_callback_period(device::BrickletJoystick)
    return device.deviceInternal.get_position_callback_period()
end

export set_analog_value_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Analog Value` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Analog Value` callback is only triggered if the analog values have
changed since the last triggering.
"""
function set_analog_value_callback_period(device::BrickletJoystick, period)
    device.deviceInternal.set_analog_value_callback_period(period)
end

export get_analog_value_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Analog Value Callback Period`.
"""
function get_analog_value_callback_period(device::BrickletJoystick)
    return device.deviceInternal.get_analog_value_callback_period()
end

export set_position_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Position Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the position is *outside* the min and max values"
 "'i'",    "Callback is triggered when the position is *inside* the min and max values"
 "'<'",    "Callback is triggered when the position is smaller than the min values (max is ignored)"
 "'>'",    "Callback is triggered when the position is greater than the min values (max is ignored)"
"""
function set_position_callback_threshold(device::BrickletJoystick, option, min_x, max_x, min_y, max_y)
    device.deviceInternal.set_position_callback_threshold(option, min_x, max_x, min_y, max_y)
end

export get_position_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Position Callback Threshold`.
"""
function get_position_callback_threshold(device::BrickletJoystick)
    return device.deviceInternal.get_position_callback_threshold()
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
 "'o'",    "Callback is triggered when the analog values are *outside* the min and max values"
 "'i'",    "Callback is triggered when the analog values are *inside* the min and max values"
 "'<'",    "Callback is triggered when the analog values are smaller than the min values (max is ignored)"
 "'>'",    "Callback is triggered when the analog values are greater than the min values (max is ignored)"
"""
function set_analog_value_callback_threshold(device::BrickletJoystick, option, min_x, max_x, min_y, max_y)
    device.deviceInternal.set_analog_value_callback_threshold(option, min_x, max_x, min_y, max_y)
end

export get_analog_value_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Analog Value Callback Threshold`.
"""
function get_analog_value_callback_threshold(device::BrickletJoystick)
    return device.deviceInternal.get_analog_value_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Position Reached`,
* :cb:`Analog Value Reached`

are triggered, if the thresholds

* :func:`Set Position Callback Threshold`,
* :func:`Set Analog Value Callback Threshold`

keep being reached.
"""
function set_debounce_period(device::BrickletJoystick, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletJoystick)
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
function get_identity(device::BrickletJoystick)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletJoystick, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
