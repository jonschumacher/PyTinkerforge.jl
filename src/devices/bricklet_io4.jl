


export BrickletIO4Configuration
struct BrickletIO4Configuration
    direction_mask::Integer
    value_mask::Integer
end

export BrickletIO4Monoflop
struct BrickletIO4Monoflop
    value::Integer
    time::Integer
    time_remaining::Integer
end

export BrickletIO4EdgeCountConfig
struct BrickletIO4EdgeCountConfig
    edge_type::Integer
    debounce::Integer
end

export BrickletIO4Identity
struct BrickletIO4Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIO4
"""
4-channel digital input/output
"""
mutable struct BrickletIO4 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIO4(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_io4")
        deviceInternal = package.BrickletIO4(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_value
"""
    $(SIGNATURES)

Sets the output value (high or low) with a bitmask (4bit). A 1 in the bitmask
means high and a 0 in the bitmask means low.

For example: The value 3 or 0b0011 will turn the pins 0-1 high and the
pins 2-3 low.

All running monoflop timers will be aborted if this function is called.

.. note::
 This function does nothing for pins that are configured as input.
 Pull-up resistors can be switched on with :func:`Set Configuration`.
"""
function set_value(device::BrickletIO4, value_mask)
    device.deviceInternal.set_value(value_mask)
end

export get_value
"""
    $(SIGNATURES)

Returns a bitmask of the values that are currently measured.
This function works if the pin is configured to input
as well as if it is configured to output.
"""
function get_value(device::BrickletIO4)
    return device.deviceInternal.get_value()
end

export set_configuration
"""
    $(SIGNATURES)

Configures the value and direction of the specified pins. Possible directions
are 'i' and 'o' for input and output.

If the direction is configured as output, the value is either high or low
(set as *true* or *false*).

If the direction is configured as input, the value is either pull-up or
default (set as *true* or *false*).

For example:

* (15, 'i', true) or (0b1111, 'i', true) will set all pins of as input pull-up.
* (8, 'i', false) or (0b1000, 'i', false) will set pin 3 of as input default (floating if nothing is connected).
* (3, 'o', false) or (0b0011, 'o', false) will set pins 0 and 1 as output low.
* (4, 'o', true) or (0b0100, 'o', true) will set pin 2 of as output high.

Running monoflop timers for the specified pins will be aborted if this
function is called.
"""
function set_configuration(device::BrickletIO4, selection_mask, direction, value)
    device.deviceInternal.set_configuration(selection_mask, direction, value)
end

export get_configuration
"""
    $(SIGNATURES)

Returns a value bitmask and a direction bitmask. A 1 in the direction bitmask
means input and a 0 in the bitmask means output.

For example: A return value of (3, 5) or (0b0011, 0b0101) for direction and
value means that:

* pin 0 is configured as input pull-up,
* pin 1 is configured as input default,
* pin 2 is configured as output high and
* pin 3 is are configured as output low.
"""
function get_configuration(device::BrickletIO4)
    return device.deviceInternal.get_configuration()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the debounce period of the :cb:`Interrupt` callback.

For example: If you set this value to 100, you will get the interrupt
maximal every 100ms. This is necessary if something that bounces is
connected to the IO-4 Bricklet, such as a button.
"""
function set_debounce_period(device::BrickletIO4, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletIO4)
    return device.deviceInternal.get_debounce_period()
end

export set_interrupt
"""
    $(SIGNATURES)

Sets the pins on which an interrupt is activated with a bitmask.
Interrupts are triggered on changes of the voltage level of the pin,
i.e. changes from high to low and low to high.

For example: An interrupt bitmask of 10 or 0b1010 will enable the interrupt for
pins 1 and 3.

The interrupt is delivered with the :cb:`Interrupt` callback.
"""
function set_interrupt(device::BrickletIO4, interrupt_mask)
    device.deviceInternal.set_interrupt(interrupt_mask)
end

export get_interrupt
"""
    $(SIGNATURES)

Returns the interrupt bitmask as set by :func:`Set Interrupt`.
"""
function get_interrupt(device::BrickletIO4)
    return device.deviceInternal.get_interrupt()
end

export set_monoflop
"""
    $(SIGNATURES)

Configures a monoflop of the pins specified by the first parameter as 4 bit
long bitmask. The specified pins must be configured for output. Non-output
pins will be ignored.

The second parameter is a bitmask with the desired value of the specified
output pins. A 1 in the bitmask means high and a 0 in the bitmask means low.

The third parameter indicates the time that the pins should hold
the value.

If this function is called with the parameters (9, 1, 1500) or
(0b1001, 0b0001, 1500): Pin 0 will get high and pin 3 will get low. In 1.5s pin
0 will get low and pin 3 will get high again.

A monoflop can be used as a fail-safe mechanism. For example: Lets assume you
have a RS485 bus and an IO-4 Bricklet connected to one of the slave
stacks. You can now call this function every second, with a time parameter
of two seconds and pin 0 set to high. Pin 0 will be high all the time. If now
the RS485 connection is lost, then pin 0 will get low in at most two seconds.
"""
function set_monoflop(device::BrickletIO4, selection_mask, value_mask, time)
    device.deviceInternal.set_monoflop(selection_mask, value_mask, time)
end

export get_monoflop
"""
    $(SIGNATURES)

Returns (for the given pin) the current value and the time as set by
:func:`Set Monoflop` as well as the remaining time until the value flips.

If the timer is not running currently, the remaining time will be returned
as 0.
"""
function get_monoflop(device::BrickletIO4, pin)
    return device.deviceInternal.get_monoflop(pin)
end

export set_selected_values
"""
    $(SIGNATURES)

Sets the output value (high or low) with a bitmask, according to
the selection mask. The bitmask is 4 bit long, *true* refers to high
and *false* refers to low.

For example: The parameters (9, 4) or (0b0110, 0b0100) will turn
pin 1 low and pin 2 high, pin 0 and 3 will remain untouched.

Running monoflop timers for the selected pins will be aborted if this
function is called.

.. note::
 This function does nothing for pins that are configured as input.
 Pull-up resistors can be switched on with :func:`Set Configuration`.
"""
function set_selected_values(device::BrickletIO4, selection_mask, value_mask)
    device.deviceInternal.set_selected_values(selection_mask, value_mask)
end

export get_edge_count
"""
    $(SIGNATURES)

Returns the current value of the edge counter for the selected pin. You can
configure the edges that are counted with :func:`Set Edge Count Config`.

If you set the reset counter to *true*, the count is set back to 0
directly after it is read.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_edge_count(device::BrickletIO4, pin, reset_counter)
    return device.deviceInternal.get_edge_count(pin, reset_counter)
end

export set_edge_count_config
"""
    $(SIGNATURES)

Configures the edge counter for the selected pins.

The edge type parameter configures if rising edges, falling edges or
both are counted if the pin is configured for input. Possible edge types are:

* 0 = rising (default)
* 1 = falling
* 2 = both

Configuring an edge counter resets its value to 0.

If you don't know what any of this means, just leave it at default. The
default configuration is very likely OK for you.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_edge_count_config(device::BrickletIO4, selection_mask, edge_type, debounce)
    device.deviceInternal.set_edge_count_config(selection_mask, edge_type, debounce)
end

export get_edge_count_config
"""
    $(SIGNATURES)

Returns the edge type and debounce time for the selected pin as set by
:func:`Set Edge Count Config`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_edge_count_config(device::BrickletIO4, pin)
    return device.deviceInternal.get_edge_count_config(pin)
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
function get_identity(device::BrickletIO4)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIO4, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
