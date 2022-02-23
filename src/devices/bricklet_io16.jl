


export BrickletIO16PortConfiguration
struct BrickletIO16PortConfiguration
    direction_mask::Integer
    value_mask::Integer
end

export BrickletIO16PortMonoflop
struct BrickletIO16PortMonoflop
    value::Integer
    time::Integer
    time_remaining::Integer
end

export BrickletIO16EdgeCountConfig
struct BrickletIO16EdgeCountConfig
    edge_type::Integer
    debounce::Integer
end

export BrickletIO16Identity
struct BrickletIO16Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIO16
"""
16-channel digital input/output
"""
mutable struct BrickletIO16 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIO16(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_io16")
        deviceInternal = package.BrickletIO16(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_port
"""
    $(SIGNATURES)

Sets the output value (high or low) for a port ("a" or "b") with a bitmask
(8bit). A 1 in the bitmask means high and a 0 in the bitmask means low.

For example: The value 15 or 0b00001111 will turn the pins 0-3 high and the
pins 4-7 low for the specified port.

All running monoflop timers of the given port will be aborted if this function
is called.

.. note::
 This function does nothing for pins that are configured as input.
 Pull-up resistors can be switched on with :func:`Set Port Configuration`.
"""
function set_port(device::BrickletIO16, port, value_mask)
    device.deviceInternal.set_port(port, value_mask)
end

export get_port
"""
    $(SIGNATURES)

Returns a bitmask of the values that are currently measured on the
specified port. This function works if the pin is configured to input
as well as if it is configured to output.
"""
function get_port(device::BrickletIO16, port)
    return device.deviceInternal.get_port(port)
end

export set_port_configuration
"""
    $(SIGNATURES)

Configures the value and direction of a specified port. Possible directions
are 'i' and 'o' for input and output.

If the direction is configured as output, the value is either high or low
(set as *true* or *false*).

If the direction is configured as input, the value is either pull-up or
default (set as *true* or *false*).

For example:

* ('a', 255, 'i', true) or ('a', 0b11111111, 'i', true) will set all pins of port A as input pull-up.
* ('a', 128, 'i', false) or ('a', 0b10000000, 'i', false) will set pin 7 of port A as input default (floating if nothing is connected).
* ('b', 3, 'o', false) or ('b', 0b00000011, 'o', false) will set pins 0 and 1 of port B as output low.
* ('b', 4, 'o', true) or ('b', 0b00000100, 'o', true) will set pin 2 of port B as output high.

Running monoflop timers for the selected pins will be aborted if this
function is called.
"""
function set_port_configuration(device::BrickletIO16, port, selection_mask, direction, value)
    device.deviceInternal.set_port_configuration(port, selection_mask, direction, value)
end

export get_port_configuration
"""
    $(SIGNATURES)

Returns a direction bitmask and a value bitmask for the specified port. A 1 in
the direction bitmask means input and a 0 in the bitmask means output.

For example: A return value of (15, 51) or (0b00001111, 0b00110011) for
direction and value means that:

* pins 0 and 1 are configured as input pull-up,
* pins 2 and 3 are configured as input default,
* pins 4 and 5 are configured as output high
* and pins 6 and 7 are configured as output low.
"""
function get_port_configuration(device::BrickletIO16, port)
    return device.deviceInternal.get_port_configuration(port)
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the debounce period of the :cb:`Interrupt` callback.

For example: If you set this value to 100, you will get the interrupt
maximal every 100ms. This is necessary if something that bounces is
connected to the IO-16 Bricklet, such as a button.
"""
function set_debounce_period(device::BrickletIO16, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletIO16)
    return device.deviceInternal.get_debounce_period()
end

export set_port_interrupt
"""
    $(SIGNATURES)

Sets the pins on which an interrupt is activated with a bitmask.
Interrupts are triggered on changes of the voltage level of the pin,
i.e. changes from high to low and low to high.

For example: ('a', 129) or ('a', 0b10000001) will enable the interrupt for
pins 0 and 7 of port a.

The interrupt is delivered with the :cb:`Interrupt` callback.
"""
function set_port_interrupt(device::BrickletIO16, port, interrupt_mask)
    device.deviceInternal.set_port_interrupt(port, interrupt_mask)
end

export get_port_interrupt
"""
    $(SIGNATURES)

Returns the interrupt bitmask for the specified port as set by
:func:`Set Port Interrupt`.
"""
function get_port_interrupt(device::BrickletIO16, port)
    return device.deviceInternal.get_port_interrupt(port)
end

export set_port_monoflop
"""
    $(SIGNATURES)

Configures a monoflop of the pins specified by the second parameter as 8 bit
long bitmask. The specified pins must be configured for output. Non-output
pins will be ignored.

The third parameter is a bitmask with the desired value of the specified
output pins. A 1 in the bitmask means high and a 0 in the bitmask means low.

The forth parameter indicates the time that the pins should hold
the value.

If this function is called with the parameters ('a', 9, 1, 1500) or
('a', 0b00001001, 0b00000001, 1500): Pin 0 will get high and pin 3 will get
low on port 'a'. In 1.5s pin 0 will get low and pin 3 will get high again.

A monoflop can be used as a fail-safe mechanism. For example: Lets assume you
have a RS485 bus and an IO-16 Bricklet connected to one of the slave
stacks. You can now call this function every second, with a time parameter
of two seconds and pin 0 set to high. Pin 0 will be high all the time. If now
the RS485 connection is lost, then pin 0 will get low in at most two seconds.
"""
function set_port_monoflop(device::BrickletIO16, port, selection_mask, value_mask, time)
    device.deviceInternal.set_port_monoflop(port, selection_mask, value_mask, time)
end

export get_port_monoflop
"""
    $(SIGNATURES)

Returns (for the given pin) the current value and the time as set by
:func:`Set Port Monoflop` as well as the remaining time until the value flips.

If the timer is not running currently, the remaining time will be returned
as 0.
"""
function get_port_monoflop(device::BrickletIO16, port, pin)
    return device.deviceInternal.get_port_monoflop(port, pin)
end

export set_selected_values
"""
    $(SIGNATURES)

Sets the output value (high or low) for a port ("a" or "b" with a bitmask,
according to the selection mask. The bitmask is 8 bit long and a 1 in the
bitmask means high and a 0 in the bitmask means low.

For example: The parameters ('a', 192, 128) or ('a', 0b11000000, 0b10000000)
will turn pin 7 high and pin 6 low on port A, pins 0-6 will remain untouched.

Running monoflop timers for the selected pins will be aborted if this
function is called.

.. note::
 This function does nothing for pins that are configured as input.
 Pull-up resistors can be switched on with :func:`Set Port Configuration`.
"""
function set_selected_values(device::BrickletIO16, port, selection_mask, value_mask)
    device.deviceInternal.set_selected_values(port, selection_mask, value_mask)
end

export get_edge_count
"""
    $(SIGNATURES)

Returns the current value of the edge counter for the selected pin on port A.
You can configure the edges that are counted with :func:`Set Edge Count Config`.

If you set the reset counter to *true*, the count is set back to 0
directly after it is read.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_edge_count(device::BrickletIO16, pin, reset_counter)
    return device.deviceInternal.get_edge_count(pin, reset_counter)
end

export set_edge_count_config
"""
    $(SIGNATURES)

Configures the edge counter for the selected pin of port A. Pins 0 and 1
are available for edge counting.

The edge type parameter configures if rising edges, falling edges or
both are counted if the pin is configured for input. Possible edge types are:

* 0 = rising
* 1 = falling
* 2 = both

Configuring an edge counter resets its value to 0.

If you don't know what any of this means, just leave it at default. The
default configuration is very likely OK for you.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_edge_count_config(device::BrickletIO16, pin, edge_type, debounce)
    device.deviceInternal.set_edge_count_config(pin, edge_type, debounce)
end

export get_edge_count_config
"""
    $(SIGNATURES)

Returns the edge type and debounce time for the selected pin of port A as set by
:func:`Set Edge Count Config`.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_edge_count_config(device::BrickletIO16, pin)
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
function get_identity(device::BrickletIO16)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIO16, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
