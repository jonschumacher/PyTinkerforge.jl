


export BrickletAccelerometerAcceleration
struct BrickletAccelerometerAcceleration
    x::Integer
    y::Integer
    z::Integer
end

export BrickletAccelerometerAccelerationCallbackThreshold
struct BrickletAccelerometerAccelerationCallbackThreshold
    option::Char
    min_x::Integer
    max_x::Integer
    min_y::Integer
    max_y::Integer
    min_z::Integer
    max_z::Integer
end

export BrickletAccelerometerConfiguration
struct BrickletAccelerometerConfiguration
    data_rate::Integer
    full_scale::Integer
    filter_bandwidth::Integer
end

export BrickletAccelerometerIdentity
struct BrickletAccelerometerIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAccelerometer
"""
Measures acceleration in three axis
"""
mutable struct BrickletAccelerometer <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAccelerometer(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_accelerometer")
        deviceInternal = package.BrickletAccelerometer(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_acceleration
"""
    $(SIGNATURES)

Returns the acceleration in x, y and z direction. The values
are given in gₙ/1000 (1gₙ = 9.80665m/s²). The range is
configured with :func:`Set Configuration`.

If you want to get the acceleration periodically, it is recommended
to use the :cb:`Acceleration` callback and set the period with
:func:`Set Acceleration Callback Period`.
"""
function get_acceleration(device::BrickletAccelerometer)
    return device.deviceInternal.get_acceleration()
end

export set_acceleration_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Acceleration` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Acceleration` callback is only triggered if the acceleration has
changed since the last triggering.
"""
function set_acceleration_callback_period(device::BrickletAccelerometer, period)
    device.deviceInternal.set_acceleration_callback_period(period)
end

export get_acceleration_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Acceleration Callback Period`.
"""
function get_acceleration_callback_period(device::BrickletAccelerometer)
    return device.deviceInternal.get_acceleration_callback_period()
end

export set_acceleration_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Acceleration Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the acceleration is *outside* the min and max values"
 "'i'",    "Callback is triggered when the acceleration is *inside* the min and max values"
 "'<'",    "Callback is triggered when the acceleration is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the acceleration is greater than the min value (max is ignored)"
"""
function set_acceleration_callback_threshold(device::BrickletAccelerometer, option, min_x, max_x, min_y, max_y, min_z, max_z)
    device.deviceInternal.set_acceleration_callback_threshold(option, min_x, max_x, min_y, max_y, min_z, max_z)
end

export get_acceleration_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Acceleration Callback Threshold`.
"""
function get_acceleration_callback_threshold(device::BrickletAccelerometer)
    return device.deviceInternal.get_acceleration_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Acceleration Reached`

is triggered, if the threshold

* :func:`Set Acceleration Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletAccelerometer, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletAccelerometer)
    return device.deviceInternal.get_debounce_period()
end

export get_temperature
"""
    $(SIGNATURES)

Returns the temperature of the accelerometer.
"""
function get_temperature(device::BrickletAccelerometer)
    return device.deviceInternal.get_temperature()
end

export set_configuration
"""
    $(SIGNATURES)

Configures the data rate, full scale range and filter bandwidth.
Possible values are:

* Data rate of 0Hz to 1600Hz.
* Full scale range of ±2gₙ up to ±16gₙ.
* Filter bandwidth between 50Hz and 800Hz.

Decreasing data rate or full scale range will also decrease the noise on
the data.
"""
function set_configuration(device::BrickletAccelerometer, data_rate, full_scale, filter_bandwidth)
    device.deviceInternal.set_configuration(data_rate, full_scale, filter_bandwidth)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletAccelerometer)
    return device.deviceInternal.get_configuration()
end

export led_on
"""
    $(SIGNATURES)

Enables the LED on the Bricklet.
"""
function led_on(device::BrickletAccelerometer)
    device.deviceInternal.led_on()
end

export led_off
"""
    $(SIGNATURES)

Disables the LED on the Bricklet.
"""
function led_off(device::BrickletAccelerometer)
    device.deviceInternal.led_off()
end

export is_led_on
"""
    $(SIGNATURES)

Returns *true* if the LED is enabled, *false* otherwise.
"""
function is_led_on(device::BrickletAccelerometer)
    return device.deviceInternal.is_led_on()
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
function get_identity(device::BrickletAccelerometer)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletAccelerometer, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
