


export BrickletIndustrialDigitalIn4EdgeCountConfig
struct BrickletIndustrialDigitalIn4EdgeCountConfig
    edge_type::Integer
    debounce::Integer
end

export BrickletIndustrialDigitalIn4Identity
struct BrickletIndustrialDigitalIn4Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialDigitalIn4
"""
4 galvanically isolated digital inputs
"""
mutable struct BrickletIndustrialDigitalIn4 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialDigitalIn4(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_digital_in_4")
        deviceInternal = package.BrickletIndustrialDigitalIn4(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_value
"""
    $(SIGNATURES)

Returns the input value with a bitmask. The bitmask is 16bit long, *true*
refers to high and *false* refers to low.

For example: The value 3 or 0b0011 means that pins 0-1 are high and the other
pins are low.

If no groups are used (see :func:`Set Group`), the pins correspond to the
markings on the IndustrialDigital In 4 Bricklet.

If groups are used, the pins correspond to the element in the group.
Element 1 in the group will get pins 0-3, element 2 pins 4-7, element 3
pins 8-11 and element 4 pins 12-15.
"""
function get_value(device::BrickletIndustrialDigitalIn4)
    return device.deviceInternal.get_value()
end

export set_group
"""
    $(SIGNATURES)

Sets a group of Digital In 4 Bricklets that should work together. You can
find Bricklets that can be grouped together with :func:`Get Available For Group`.

The group consists of 4 elements. Element 1 in the group will get pins 0-3,
element 2 pins 4-7, element 3 pins 8-11 and element 4 pins 12-15.

Each element can either be one of the ports ('a' to 'd') or 'n' if it should
not be used.

For example: If you have two Digital In 4 Bricklets connected to port A and
port B respectively, you could call with ``['a', 'b', 'n', 'n']``.

Now the pins on the Digital In 4 on port A are assigned to 0-3 and the
pins on the Digital In 4 on port B are assigned to 4-7. It is now possible
to call :func:`Get Value` and read out two Bricklets at the same time.

Changing the group configuration resets all edge counter configurations
and values.
"""
function set_group(device::BrickletIndustrialDigitalIn4, group)
    device.deviceInternal.set_group(group)
end

export get_group
"""
    $(SIGNATURES)

Returns the group as set by :func:`Set Group`
"""
function get_group(device::BrickletIndustrialDigitalIn4)
    return device.deviceInternal.get_group()
end

export get_available_for_group
"""
    $(SIGNATURES)

Returns a bitmask of ports that are available for grouping. For example the
value 5 or 0b0101 means: Port A and port C are connected to Bricklets that
can be grouped together.
"""
function get_available_for_group(device::BrickletIndustrialDigitalIn4)
    return device.deviceInternal.get_available_for_group()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the debounce period of the :cb:`Interrupt` callback.

For example: If you set this value to 100, you will get the interrupt
maximal every 100ms. This is necessary if something that bounces is
connected to the Digital In 4 Bricklet, such as a button.
"""
function set_debounce_period(device::BrickletIndustrialDigitalIn4, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletIndustrialDigitalIn4)
    return device.deviceInternal.get_debounce_period()
end

export set_interrupt
"""
    $(SIGNATURES)

Sets the pins on which an interrupt is activated with a bitmask.
Interrupts are triggered on changes of the voltage level of the pin,
i.e. changes from high to low and low to high.

For example: An interrupt bitmask of 9 or 0b1001 will enable the interrupt for
pins 0 and 3.

The interrupts use the grouping as set by :func:`Set Group`.

The interrupt is delivered with the :cb:`Interrupt` callback.
"""
function set_interrupt(device::BrickletIndustrialDigitalIn4, interrupt_mask)
    device.deviceInternal.set_interrupt(interrupt_mask)
end

export get_interrupt
"""
    $(SIGNATURES)

Returns the interrupt bitmask as set by :func:`Set Interrupt`.
"""
function get_interrupt(device::BrickletIndustrialDigitalIn4)
    return device.deviceInternal.get_interrupt()
end

export get_edge_count
"""
    $(SIGNATURES)

Returns the current value of the edge counter for the selected pin. You can
configure the edges that are counted with :func:`Set Edge Count Config`.

If you set the reset counter to *true*, the count is set back to 0
directly after it is read.

The edge counters use the grouping as set by :func:`Set Group`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_edge_count(device::BrickletIndustrialDigitalIn4, pin, reset_counter)
    return device.deviceInternal.get_edge_count(pin, reset_counter)
end

export set_edge_count_config
"""
    $(SIGNATURES)

Configures the edge counter for the selected pins. A bitmask of 9 or 0b1001 will
enable the edge counter for pins 0 and 3.

The edge type parameter configures if rising edges, falling edges or
both are counted if the pin is configured for input. Possible edge types are:

* 0 = rising
* 1 = falling
* 2 = both

Configuring an edge counter resets its value to 0.

If you don't know what any of this means, just leave it at default. The
default configuration is very likely OK for you.

The edge counters use the grouping as set by :func:`Set Group`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_edge_count_config(device::BrickletIndustrialDigitalIn4, selection_mask, edge_type, debounce)
    device.deviceInternal.set_edge_count_config(selection_mask, edge_type, debounce)
end

export get_edge_count_config
"""
    $(SIGNATURES)

Returns the edge type and debounce time for the selected pin as set by
:func:`Set Edge Count Config`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_edge_count_config(device::BrickletIndustrialDigitalIn4, pin)
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
function get_identity(device::BrickletIndustrialDigitalIn4)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIndustrialDigitalIn4, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
