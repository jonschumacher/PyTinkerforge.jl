


export BrickletRemoteSwitchV2RemoteConfiguration
struct BrickletRemoteSwitchV2RemoteConfiguration
    remote_type::Integer
    minimum_repeats::Integer
    callback_enabled::Bool
end

export BrickletRemoteSwitchV2RemoteStatusA
struct BrickletRemoteSwitchV2RemoteStatusA
    house_code::Integer
    receiver_code::Integer
    switch_to::Integer
    repeats::Integer
end

export BrickletRemoteSwitchV2RemoteStatusB
struct BrickletRemoteSwitchV2RemoteStatusB
    address::Integer
    unit::Integer
    switch_to::Integer
    dim_value::Integer
    repeats::Integer
end

export BrickletRemoteSwitchV2RemoteStatusC
struct BrickletRemoteSwitchV2RemoteStatusC
    system_code::Char
    device_code::Integer
    switch_to::Integer
    repeats::Integer
end

export BrickletRemoteSwitchV2SPITFPErrorCount
struct BrickletRemoteSwitchV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletRemoteSwitchV2Identity
struct BrickletRemoteSwitchV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRemoteSwitchV2
"""
Controls remote mains switches and receives signals from remotes
"""
mutable struct BrickletRemoteSwitchV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRemoteSwitchV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_remote_switch_v2")
        deviceInternal = package.BrickletRemoteSwitchV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_switching_state
"""
    $(SIGNATURES)

Returns the current switching state. If the current state is busy, the
Bricklet is currently sending a code to switch a socket. It will not
accept any calls of switch socket functions until the state changes to ready.

How long the switching takes is dependent on the number of repeats, see
:func:`Set Repeats`.
"""
function get_switching_state(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_switching_state()
end

export set_repeats
"""
    $(SIGNATURES)

Sets the number of times the code is sent when one of the Switch Socket
functions is called. The repeats basically correspond to the amount of time
that a button of the remote is pressed.

Some dimmers are controlled by the length of a button pressed,
this can be simulated by increasing the repeats.
"""
function set_repeats(device::BrickletRemoteSwitchV2, repeats)
    device.deviceInternal.set_repeats(repeats)
end

export get_repeats
"""
    $(SIGNATURES)

Returns the number of repeats as set by :func:`Set Repeats`.
"""
function get_repeats(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_repeats()
end

export switch_socket_a
"""
    $(SIGNATURES)

To switch a type A socket you have to give the house code, receiver code and the
state (on or off) you want to switch to.

A detailed description on how you can figure out the house and receiver code
can be found :ref:`here <remote_switch_bricklet_type_a_house_and_receiver_code>`.
"""
function switch_socket_a(device::BrickletRemoteSwitchV2, house_code, receiver_code, switch_to)
    device.deviceInternal.switch_socket_a(house_code, receiver_code, switch_to)
end

export switch_socket_b
"""
    $(SIGNATURES)

To switch a type B socket you have to give the address, unit and the state
(on or off) you want to switch to.

To switch all devices with the same address use 255 for the unit.

A detailed description on how you can teach a socket the address and unit can
be found :ref:`here <remote_switch_bricklet_type_b_address_and_unit>`.
"""
function switch_socket_b(device::BrickletRemoteSwitchV2, address, unit, switch_to)
    device.deviceInternal.switch_socket_b(address, unit, switch_to)
end

export dim_socket_b
"""
    $(SIGNATURES)

To control a type B dimmer you have to give the address, unit and the
dim value you want to set the dimmer to.

A detailed description on how you can teach a dimmer the address and unit can
be found :ref:`here <remote_switch_bricklet_type_b_address_and_unit>`.
"""
function dim_socket_b(device::BrickletRemoteSwitchV2, address, unit, dim_value)
    device.deviceInternal.dim_socket_b(address, unit, dim_value)
end

export switch_socket_c
"""
    $(SIGNATURES)

To switch a type C socket you have to give the system code, device code and the
state (on or off) you want to switch to.

A detailed description on how you can figure out the system and device code
can be found :ref:`here <remote_switch_bricklet_type_c_system_and_device_code>`.
"""
function switch_socket_c(device::BrickletRemoteSwitchV2, system_code, device_code, switch_to)
    device.deviceInternal.switch_socket_c(system_code, device_code, switch_to)
end

export set_remote_configuration
"""
    $(SIGNATURES)

Sets the configuration for **receiving** data from a remote of type A, B or C.

* Remote Type: A, B or C depending on the type of remote you want to receive.
* Minimum Repeats: The minimum number of repeated data packets until the callback
  is triggered (if enabled).
* Callback Enabled: Enable or disable callback (see :cb:`Remote Status A` callback,
  :cb:`Remote Status B` callback and :cb:`Remote Status C` callback).
"""
function set_remote_configuration(device::BrickletRemoteSwitchV2, remote_type, minimum_repeats, callback_enabled)
    device.deviceInternal.set_remote_configuration(remote_type, minimum_repeats, callback_enabled)
end

export get_remote_configuration
"""
    $(SIGNATURES)

Returns the remote configuration as set by :func:`Set Remote Configuration`
"""
function get_remote_configuration(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_remote_configuration()
end

export get_remote_status_a
"""
    $(SIGNATURES)

Returns the house code, receiver code, switch state (on/off) and number of
repeats for remote type A.

Repeats == 0 means there was no button press. Repeats >= 1 means there
was a button press with the specified house/receiver code. The repeats are the
number of received identical data packets. The longer the button is pressed,
the higher the repeat number.

Use the callback to get this data automatically when a button is pressed,
see :func:`Set Remote Configuration` and :cb:`Remote Status A` callback.
"""
function get_remote_status_a(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_remote_status_a()
end

export get_remote_status_b
"""
    $(SIGNATURES)

Returns the address (unique per remote), unit (button number), switch state
(on/off) and number of repeats for remote type B.

If the remote supports dimming the dim value is used instead of the switch state.

If repeats=0 there was no button press. If repeats >= 1 there
was a button press with the specified address/unit. The repeats are the number of received
identical data packets. The longer the button is pressed, the higher the repeat number.

Use the callback to get this data automatically when a button is pressed,
see :func:`Set Remote Configuration` and :cb:`Remote Status B` callback.
"""
function get_remote_status_b(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_remote_status_b()
end

export get_remote_status_c
"""
    $(SIGNATURES)

Returns the system code, device code, switch state (on/off) and number of repeats for
remote type C.

If repeats=0 there was no button press. If repeats >= 1 there
was a button press with the specified system/device code. The repeats are the number of received
identical data packets. The longer the button is pressed, the higher the repeat number.

Use the callback to get this data automatically when a button is pressed,
see :func:`Set Remote Configuration` and :cb:`Remote Status C` callback.
"""
function get_remote_status_c(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_remote_status_c()
end

export get_spitfp_error_count
"""
    $(SIGNATURES)

Returns the error count for the communication between Brick and Bricklet.

The errors are divided into

* ACK checksum errors,
* message checksum errors,
* framing errors and
* overflow errors.

The errors counts are for errors that occur on the Bricklet side. All
Bricks have a similar function that returns the errors on the Brick side.
"""
function get_spitfp_error_count(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_spitfp_error_count()
end

export set_bootloader_mode
"""
    $(SIGNATURES)

Sets the bootloader mode and returns the status after the requested
mode change was instigated.

You can change from bootloader mode to firmware mode and vice versa. A change
from bootloader mode to firmware mode will only take place if the entry function,
device identifier and CRC are present and correct.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_bootloader_mode(device::BrickletRemoteSwitchV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_bootloader_mode()
end

export set_write_firmware_pointer
"""
    $(SIGNATURES)

Sets the firmware pointer for :func:`Write Firmware`. The pointer has
to be increased by chunks of size 64. The data is written to flash
every 4 chunks (which equals to one page of size 256).

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_write_firmware_pointer(device::BrickletRemoteSwitchV2, pointer)
    device.deviceInternal.set_write_firmware_pointer(pointer)
end

export write_firmware
"""
    $(SIGNATURES)

Writes 64 Bytes of firmware at the position as written by
:func:`Set Write Firmware Pointer` before. The firmware is written
to flash every 4 chunks.

You can only write firmware in bootloader mode.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function write_firmware(device::BrickletRemoteSwitchV2, data)
    return device.deviceInternal.write_firmware(data)
end

export set_status_led_config
"""
    $(SIGNATURES)

Sets the status LED configuration. By default the LED shows
communication traffic between Brick and Bricklet, it flickers once
for every 10 received data packets.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is will show heartbeat by default.
"""
function set_status_led_config(device::BrickletRemoteSwitchV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_status_led_config()
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature as measured inside the microcontroller. The
value returned is not the ambient temperature!

The temperature is only proportional to the real temperature and it has bad
accuracy. Practically it is only useful as an indicator for
temperature changes.
"""
function get_chip_temperature(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_chip_temperature()
end

export reset
"""
    $(SIGNATURES)

Calling this function will reset the Bricklet. All configurations
will be lost.

After a reset you have to create new device objects,
calling functions on the existing ones will result in
undefined behavior!
"""
function reset(device::BrickletRemoteSwitchV2)
    device.deviceInternal.reset()
end

export write_uid
"""
    $(SIGNATURES)

Writes a new UID into flash. If you want to set a new UID
you have to decode the Base58 encoded UID string into an
integer first.

We recommend that you use Brick Viewer to change the UID.
"""
function write_uid(device::BrickletRemoteSwitchV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.read_uid()
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
function get_identity(device::BrickletRemoteSwitchV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRemoteSwitchV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
