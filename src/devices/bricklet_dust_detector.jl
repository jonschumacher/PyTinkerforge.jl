


export BrickletDustDetectorDustDensityCallbackThreshold
struct BrickletDustDetectorDustDensityCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletDustDetectorIdentity
struct BrickletDustDetectorIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletDustDetector
"""
Measures dust density
"""
mutable struct BrickletDustDetector <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletDustDetector(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_dust_detector")
        deviceInternal = package.BrickletDustDetector(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_dust_density
"""
    $(SIGNATURES)

Returns the dust density.

If you want to get the dust density periodically, it is recommended
to use the :cb:`Dust Density` callback and set the period with
:func:`Set Dust Density Callback Period`.
"""
function get_dust_density(device::BrickletDustDetector)
    return device.deviceInternal.get_dust_density()
end

export set_dust_density_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Dust Density` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Dust Density` callback is only triggered if the dust density has
changed since the last triggering.
"""
function set_dust_density_callback_period(device::BrickletDustDetector, period)
    device.deviceInternal.set_dust_density_callback_period(period)
end

export get_dust_density_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Dust Density Callback Period`.
"""
function get_dust_density_callback_period(device::BrickletDustDetector)
    return device.deviceInternal.get_dust_density_callback_period()
end

export set_dust_density_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Dust Density Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the dust density value is *outside* the min and max values"
 "'i'",    "Callback is triggered when the dust density value is *inside* the min and max values"
 "'<'",    "Callback is triggered when the dust density value is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the dust density value is greater than the min value (max is ignored)"
"""
function set_dust_density_callback_threshold(device::BrickletDustDetector, option, min, max)
    device.deviceInternal.set_dust_density_callback_threshold(option, min, max)
end

export get_dust_density_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Dust Density Callback Threshold`.
"""
function get_dust_density_callback_threshold(device::BrickletDustDetector)
    return device.deviceInternal.get_dust_density_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Dust Density Reached`

is triggered, if the threshold

* :func:`Set Dust Density Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletDustDetector, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletDustDetector)
    return device.deviceInternal.get_debounce_period()
end

export set_moving_average
"""
    $(SIGNATURES)

Sets the length of a `moving averaging <https://en.wikipedia.org/wiki/Moving_average>`__
for the dust density.

Setting the length to 0 will turn the averaging completely off. With less
averaging, there is more noise on the data.
"""
function set_moving_average(device::BrickletDustDetector, average)
    device.deviceInternal.set_moving_average(average)
end

export get_moving_average
"""
    $(SIGNATURES)

Returns the length moving average as set by :func:`Set Moving Average`.
"""
function get_moving_average(device::BrickletDustDetector)
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
function get_identity(device::BrickletDustDetector)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletDustDetector, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
