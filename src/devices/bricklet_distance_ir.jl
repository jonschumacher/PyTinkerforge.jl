


export BrickletDistanceIRDistanceCallbackThreshold
struct BrickletDistanceIRDistanceCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletDistanceIRAnalogValueCallbackThreshold
struct BrickletDistanceIRAnalogValueCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletDistanceIRIdentity
struct BrickletDistanceIRIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletDistanceIR
"""
Measures distance up to 150cm with infrared light
"""
mutable struct BrickletDistanceIR <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletDistanceIR(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_distance_ir")
        deviceInternal = package.BrickletDistanceIR(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_distance
"""
    $(SIGNATURES)

Returns the distance measured by the sensor. Possible
distance ranges are 40 to 300, 100 to 800 and 200 to 1500, depending on the
selected IR sensor.

If you want to get the distance periodically, it is recommended to use the
:cb:`Distance` callback and set the period with
:func:`Set Distance Callback Period`.
"""
function get_distance(device::BrickletDistanceIR)
    return device.deviceInternal.get_distance()
end

export get_analog_value
"""
    $(SIGNATURES)

Returns the value as read by a 12-bit analog-to-digital converter.

.. note::
 The value returned by :func:`Get Distance` is averaged over several samples
 to yield less noise, while :func:`Get Analog Value` gives back raw
 unfiltered analog values. The only reason to use :func:`Get Analog Value` is,
 if you need the full resolution of the analog-to-digital converter.

If you want the analog value periodically, it is recommended to use the
:cb:`Analog Value` callback and set the period with
:func:`Set Analog Value Callback Period`.
"""
function get_analog_value(device::BrickletDistanceIR)
    return device.deviceInternal.get_analog_value()
end

export set_sampling_point
"""
    $(SIGNATURES)

Sets a sampling point value to a specific position of the lookup table.
The lookup table comprises 128 equidistant analog values with
corresponding distances.

If you measure a distance of 50cm at the analog value 2048, you
should call this function with (64, 5000). The utilized analog-to-digital
converter has a resolution of 12 bit. With 128 sampling points on the
whole range, this means that every sampling point has a size of 32
analog values. Thus the analog value 2048 has the corresponding sampling
point 64 = 2048/32.

Sampling points are saved on the EEPROM of the Distance IR Bricklet and
loaded again on startup.

.. note::
 An easy way to calibrate the sampling points of the Distance IR Bricklet is
 implemented in the Brick Viewer. If you want to calibrate your Bricklet it is
 highly recommended to use this implementation.
"""
function set_sampling_point(device::BrickletDistanceIR, position, distance)
    device.deviceInternal.set_sampling_point(position, distance)
end

export get_sampling_point
"""
    $(SIGNATURES)

Returns the distance to a sampling point position as set by
:func:`Set Sampling Point`.
"""
function get_sampling_point(device::BrickletDistanceIR, position)
    return device.deviceInternal.get_sampling_point(position)
end

export set_distance_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Distance` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Distance` callback is only triggered if the distance has changed since the
last triggering.
"""
function set_distance_callback_period(device::BrickletDistanceIR, period)
    device.deviceInternal.set_distance_callback_period(period)
end

export get_distance_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Distance Callback Period`.
"""
function get_distance_callback_period(device::BrickletDistanceIR)
    return device.deviceInternal.get_distance_callback_period()
end

export set_analog_value_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Analog Value` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Analog Value` callback is only triggered if the analog value has
changed since the last triggering.
"""
function set_analog_value_callback_period(device::BrickletDistanceIR, period)
    device.deviceInternal.set_analog_value_callback_period(period)
end

export get_analog_value_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Analog Value Callback Period`.
"""
function get_analog_value_callback_period(device::BrickletDistanceIR)
    return device.deviceInternal.get_analog_value_callback_period()
end

export set_distance_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Distance Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the distance is *outside* the min and max values"
 "'i'",    "Callback is triggered when the distance is *inside* the min and max values"
 "'<'",    "Callback is triggered when the distance is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the distance is greater than the min value (max is ignored)"
"""
function set_distance_callback_threshold(device::BrickletDistanceIR, option, min, max)
    device.deviceInternal.set_distance_callback_threshold(option, min, max)
end

export get_distance_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Distance Callback Threshold`.
"""
function get_distance_callback_threshold(device::BrickletDistanceIR)
    return device.deviceInternal.get_distance_callback_threshold()
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
function set_analog_value_callback_threshold(device::BrickletDistanceIR, option, min, max)
    device.deviceInternal.set_analog_value_callback_threshold(option, min, max)
end

export get_analog_value_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Analog Value Callback Threshold`.
"""
function get_analog_value_callback_threshold(device::BrickletDistanceIR)
    return device.deviceInternal.get_analog_value_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Distance Reached`,
* :cb:`Analog Value Reached`

are triggered, if the thresholds

* :func:`Set Distance Callback Threshold`,
* :func:`Set Analog Value Callback Threshold`

keep being reached.
"""
function set_debounce_period(device::BrickletDistanceIR, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletDistanceIR)
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
function get_identity(device::BrickletDistanceIR)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletDistanceIR, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
