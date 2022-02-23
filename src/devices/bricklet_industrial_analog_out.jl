


export BrickletIndustrialAnalogOutConfiguration
struct BrickletIndustrialAnalogOutConfiguration
    voltage_range::Integer
    current_range::Integer
end

export BrickletIndustrialAnalogOutIdentity
struct BrickletIndustrialAnalogOutIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialAnalogOut
"""
Generates configurable DC voltage and current, 0V to 10V and 4mA to 20mA
"""
mutable struct BrickletIndustrialAnalogOut <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialAnalogOut(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_analog_out")
        deviceInternal = package.BrickletIndustrialAnalogOut(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export enable
"""
    $(SIGNATURES)

Enables the output of voltage and current.

The default is disabled.
"""
function enable(device::BrickletIndustrialAnalogOut)
    device.deviceInternal.enable()
end

export disable
"""
    $(SIGNATURES)

Disables the output of voltage and current.

The default is disabled.
"""
function disable(device::BrickletIndustrialAnalogOut)
    device.deviceInternal.disable()
end

export is_enabled
"""
    $(SIGNATURES)

Returns *true* if output of voltage and current is enabled, *false* otherwise.
"""
function is_enabled(device::BrickletIndustrialAnalogOut)
    return device.deviceInternal.is_enabled()
end

export set_voltage
"""
    $(SIGNATURES)

Sets the output voltage.

The output voltage and output current are linked. Changing the output voltage
also changes the output current.
"""
function set_voltage(device::BrickletIndustrialAnalogOut, voltage)
    device.deviceInternal.set_voltage(voltage)
end

export get_voltage
"""
    $(SIGNATURES)

Returns the voltage as set by :func:`Set Voltage`.
"""
function get_voltage(device::BrickletIndustrialAnalogOut)
    return device.deviceInternal.get_voltage()
end

export set_current
"""
    $(SIGNATURES)

Sets the output current.

The output current and output voltage are linked. Changing the output current
also changes the output voltage.
"""
function set_current(device::BrickletIndustrialAnalogOut, current)
    device.deviceInternal.set_current(current)
end

export get_current
"""
    $(SIGNATURES)

Returns the current as set by :func:`Set Current`.
"""
function get_current(device::BrickletIndustrialAnalogOut)
    return device.deviceInternal.get_current()
end

export set_configuration
"""
    $(SIGNATURES)

Configures the voltage and current range.

Possible voltage ranges are:

* 0V to 5V
* 0V to 10V

Possible current ranges are:

* 4mA to 20mA
* 0mA to 20mA
* 0mA to 24mA

The resolution will always be 12 bit. This means, that the
precision is higher with a smaller range.
"""
function set_configuration(device::BrickletIndustrialAnalogOut, voltage_range, current_range)
    device.deviceInternal.set_configuration(voltage_range, current_range)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletIndustrialAnalogOut)
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
function get_identity(device::BrickletIndustrialAnalogOut)
    return device.deviceInternal.get_identity()
end
