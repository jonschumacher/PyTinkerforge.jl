


export BrickletMultiTouchIdentity
struct BrickletMultiTouchIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletMultiTouch
"""
Capacitive touch sensor for 12 electrodes
"""
mutable struct BrickletMultiTouch <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletMultiTouch(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_multi_touch")
        deviceInternal = package.BrickletMultiTouch(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_touch_state
"""
    $(SIGNATURES)

Returns the current touch state. The state is given as a bitfield.

Bits 0 to 11 represent the 12 electrodes and bit 12 represents
the proximity.

If an electrode is touched, the corresponding bit is *true*. If
a hand or similar is in proximity to the electrodes, bit 12 is
*true*.

Example: The state 4103 = 0x1007 = 0b1000000000111 means that
electrodes 0, 1 and 2 are touched and that something is in the
proximity of the electrodes.

The proximity is activated with a distance of 1-2cm. An electrode
is already counted as touched if a finger is nearly touching the
electrode. This means that you can put a piece of paper or foil
or similar on top of a electrode to build a touch panel with
a professional look.
"""
function get_touch_state(device::BrickletMultiTouch)
    return device.deviceInternal.get_touch_state()
end

export recalibrate
"""
    $(SIGNATURES)

Recalibrates the electrodes. Call this function whenever you changed
or moved you electrodes.
"""
function recalibrate(device::BrickletMultiTouch)
    device.deviceInternal.recalibrate()
end

export set_electrode_config
"""
    $(SIGNATURES)

Enables/disables electrodes with a bitfield (see :func:`Get Touch State`).

*True* enables the electrode, *false* disables the electrode. A
disabled electrode will always return *false* as its state. If you
don't need all electrodes you can disable the electrodes that are
not needed.

It is recommended that you disable the proximity bit (bit 12) if
the proximity feature is not needed. This will reduce the amount of
traffic that is produced by the :cb:`Touch State` callback.

Disabling electrodes will also reduce power consumption.

Default: 8191 = 0x1FFF = 0b1111111111111 (all electrodes and proximity feature enabled)
"""
function set_electrode_config(device::BrickletMultiTouch, enabled_electrodes)
    device.deviceInternal.set_electrode_config(enabled_electrodes)
end

export get_electrode_config
"""
    $(SIGNATURES)

Returns the electrode configuration, as set by :func:`Set Electrode Config`.
"""
function get_electrode_config(device::BrickletMultiTouch)
    return device.deviceInternal.get_electrode_config()
end

export set_electrode_sensitivity
"""
    $(SIGNATURES)

Sets the sensitivity of the electrodes. An electrode with a high sensitivity
will register a touch earlier then an electrode with a low sensitivity.

If you build a big electrode you might need to decrease the sensitivity, since
the area that can be charged will get bigger. If you want to be able to
activate an electrode from further away you need to increase the sensitivity.

After a new sensitivity is set, you likely want to call :func:`Recalibrate`
to calibrate the electrodes with the newly defined sensitivity.
"""
function set_electrode_sensitivity(device::BrickletMultiTouch, sensitivity)
    device.deviceInternal.set_electrode_sensitivity(sensitivity)
end

export get_electrode_sensitivity
"""
    $(SIGNATURES)

Returns the current sensitivity, as set by :func:`Set Electrode Sensitivity`.
"""
function get_electrode_sensitivity(device::BrickletMultiTouch)
    return device.deviceInternal.get_electrode_sensitivity()
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
function get_identity(device::BrickletMultiTouch)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletMultiTouch, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
