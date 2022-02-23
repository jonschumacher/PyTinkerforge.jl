


export BrickletDualButtonV2LEDState
struct BrickletDualButtonV2LEDState
    led_l::Integer
    led_r::Integer
end

export BrickletDualButtonV2ButtonState
struct BrickletDualButtonV2ButtonState
    button_l::Integer
    button_r::Integer
end

export BrickletDualButtonV2SPITFPErrorCount
struct BrickletDualButtonV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletDualButtonV2Identity
struct BrickletDualButtonV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletDualButtonV2
"""
Two tactile buttons with built-in blue LEDs
"""
mutable struct BrickletDualButtonV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletDualButtonV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_dual_button_v2")
        deviceInternal = package.BrickletDualButtonV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_led_state
"""
    $(SIGNATURES)

Sets the state of the LEDs. Possible states are:

* 0 = AutoToggleOn: Enables auto toggle with initially enabled LED.
* 1 = AutoToggleOff: Activates auto toggle with initially disabled LED.
* 2 = On: Enables LED (auto toggle is disabled).
* 3 = Off: Disables LED (auto toggle is disabled).

In auto toggle mode the LED is toggled automatically at each press of a button.

If you just want to set one of the LEDs and don't know the current state
of the other LED, you can get the state with :func:`Get LED State` or you
can use :func:`Set Selected LED State`.
"""
function set_led_state(device::BrickletDualButtonV2, led_l, led_r)
    device.deviceInternal.set_led_state(led_l, led_r)
end

export get_led_state
"""
    $(SIGNATURES)

Returns the current state of the LEDs, as set by :func:`Set LED State`.
"""
function get_led_state(device::BrickletDualButtonV2)
    return device.deviceInternal.get_led_state()
end

export get_button_state
"""
    $(SIGNATURES)

Returns the current state for both buttons. Possible states are:

* 0 = pressed
* 1 = released
"""
function get_button_state(device::BrickletDualButtonV2)
    return device.deviceInternal.get_button_state()
end

export set_selected_led_state
"""
    $(SIGNATURES)

Sets the state of the selected LED.

The other LED remains untouched.
"""
function set_selected_led_state(device::BrickletDualButtonV2, led, state)
    device.deviceInternal.set_selected_led_state(led, state)
end

export set_state_changed_callback_configuration
"""
    $(SIGNATURES)

If you enable this callback, the :cb:`State Changed` callback is triggered
every time a button is pressed/released
"""
function set_state_changed_callback_configuration(device::BrickletDualButtonV2, enabled)
    device.deviceInternal.set_state_changed_callback_configuration(enabled)
end

export get_state_changed_callback_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set State Changed Callback Configuration`.
"""
function get_state_changed_callback_configuration(device::BrickletDualButtonV2)
    return device.deviceInternal.get_state_changed_callback_configuration()
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
function get_spitfp_error_count(device::BrickletDualButtonV2)
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
function set_bootloader_mode(device::BrickletDualButtonV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletDualButtonV2)
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
function set_write_firmware_pointer(device::BrickletDualButtonV2, pointer)
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
function write_firmware(device::BrickletDualButtonV2, data)
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
function set_status_led_config(device::BrickletDualButtonV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletDualButtonV2)
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
function get_chip_temperature(device::BrickletDualButtonV2)
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
function reset(device::BrickletDualButtonV2)
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
function write_uid(device::BrickletDualButtonV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletDualButtonV2)
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
function get_identity(device::BrickletDualButtonV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletDualButtonV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
