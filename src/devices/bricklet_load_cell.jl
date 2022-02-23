


export BrickletLoadCellWeightCallbackThreshold
struct BrickletLoadCellWeightCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletLoadCellConfiguration
struct BrickletLoadCellConfiguration
    rate::Integer
    gain::Integer
end

export BrickletLoadCellIdentity
struct BrickletLoadCellIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletLoadCell
"""
Measures weight with a load cell
"""
mutable struct BrickletLoadCell <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletLoadCell(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_load_cell")
        deviceInternal = package.BrickletLoadCell(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_weight
"""
    $(SIGNATURES)

Returns the currently measured weight.

If you want to get the weight periodically, it is recommended
to use the :cb:`Weight` callback and set the period with
:func:`Set Weight Callback Period`.
"""
function get_weight(device::BrickletLoadCell)
    return device.deviceInternal.get_weight()
end

export set_weight_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Weight` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Weight` callback is only triggered if the weight has changed since the
last triggering.
"""
function set_weight_callback_period(device::BrickletLoadCell, period)
    device.deviceInternal.set_weight_callback_period(period)
end

export get_weight_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Weight Callback Period`.
"""
function get_weight_callback_period(device::BrickletLoadCell)
    return device.deviceInternal.get_weight_callback_period()
end

export set_weight_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Weight Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the weight is *outside* the min and max values"
 "'i'",    "Callback is triggered when the weight is *inside* the min and max values"
 "'<'",    "Callback is triggered when the weight is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the weight is greater than the min value (max is ignored)"
"""
function set_weight_callback_threshold(device::BrickletLoadCell, option, min, max)
    device.deviceInternal.set_weight_callback_threshold(option, min, max)
end

export get_weight_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Weight Callback Threshold`.
"""
function get_weight_callback_threshold(device::BrickletLoadCell)
    return device.deviceInternal.get_weight_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Weight Reached`

is triggered, if the threshold

* :func:`Set Weight Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletLoadCell, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletLoadCell)
    return device.deviceInternal.get_debounce_period()
end

export set_moving_average
"""
    $(SIGNATURES)

Sets the length of a `moving averaging <https://en.wikipedia.org/wiki/Moving_average>`__
for the weight value.

Setting the length to 1 will turn the averaging off. With less
averaging, there is more noise on the data.
"""
function set_moving_average(device::BrickletLoadCell, average)
    device.deviceInternal.set_moving_average(average)
end

export get_moving_average
"""
    $(SIGNATURES)

Returns the length moving average as set by :func:`Set Moving Average`.
"""
function get_moving_average(device::BrickletLoadCell)
    return device.deviceInternal.get_moving_average()
end

export led_on
"""
    $(SIGNATURES)

Turns the LED on.
"""
function led_on(device::BrickletLoadCell)
    device.deviceInternal.led_on()
end

export led_off
"""
    $(SIGNATURES)

Turns the LED off.
"""
function led_off(device::BrickletLoadCell)
    device.deviceInternal.led_off()
end

export is_led_on
"""
    $(SIGNATURES)

Returns *true* if the led is on, *false* otherwise.
"""
function is_led_on(device::BrickletLoadCell)
    return device.deviceInternal.is_led_on()
end

export calibrate
"""
    $(SIGNATURES)

To calibrate your Load Cell Bricklet you have to

* empty the scale and call this function with 0 and
* add a known weight to the scale and call this function with the weight.

The calibration is saved in the EEPROM of the Bricklet and only
needs to be done once.

We recommend to use the Brick Viewer for calibration, you don't need
to call this function in your source code.
"""
function calibrate(device::BrickletLoadCell, weight)
    device.deviceInternal.calibrate(weight)
end

export tare
"""
    $(SIGNATURES)

Sets the currently measured weight as tare weight.
"""
function tare(device::BrickletLoadCell)
    device.deviceInternal.tare()
end

export set_configuration
"""
    $(SIGNATURES)

The measurement rate and gain are configurable.

The rate can be either 10Hz or 80Hz. A faster rate will produce more noise.
It is additionally possible to add a moving average
(see :func:`Set Moving Average`) to the measurements.

The gain can be 128x, 64x or 32x. It represents a measurement range of
±20mV, ±40mV and ±80mV respectively. The Load Cell Bricklet uses an
excitation voltage of 5V and most load cells use an output of 2mV/V. That
means the voltage range is ±15mV for most load cells (i.e. gain of 128x
is best). If you don't know what all of this means you should keep it at
128x, it will most likely be correct.

The configuration is saved in the EEPROM of the Bricklet and only
needs to be done once.

We recommend to use the Brick Viewer for configuration, you don't need
to call this function in your source code.
"""
function set_configuration(device::BrickletLoadCell, rate, gain)
    device.deviceInternal.set_configuration(rate, gain)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletLoadCell)
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
function get_identity(device::BrickletLoadCell)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletLoadCell, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
