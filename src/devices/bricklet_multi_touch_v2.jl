


export BrickletMultiTouchV2TouchStateCallbackConfiguration
struct BrickletMultiTouchV2TouchStateCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletMultiTouchV2SPITFPErrorCount
struct BrickletMultiTouchV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletMultiTouchV2Identity
struct BrickletMultiTouchV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletMultiTouchV2
"""
Capacitive touch sensor for 12 electrodes
"""
mutable struct BrickletMultiTouchV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletMultiTouchV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_multi_touch_v2")
        deviceInternal = package.BrickletMultiTouchV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_touch_state
"""
    $(SIGNATURES)

Returns the current touch state. The state is given as a array of
bools.

Element 0 to 11 represent the 12 electrodes and element 12 represents
the proximity.

If an electrode is touched, the corresponding element is *true*. If
a hand or similar is in proximity to the electrodes, element 12 is
*true*.

The proximity is activated with a distance of 1-2cm. An electrode
is already counted as touched if a finger is nearly touching the
electrode. This means that you can put a piece of paper or foil
or similar on top of a electrode to build a touch panel with
a professional look.

If you want to get the value periodically, it is recommended to use the
:cb:`Touch State` callback. You can set the callback configuration
with :func:`Set Touch State Callback Configuration`.
"""
function get_touch_state(device::BrickletMultiTouchV2)
    return device.deviceInternal.get_touch_state()
end

export set_touch_state_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Touch State` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_touch_state_callback_configuration(device::BrickletMultiTouchV2, period, value_has_to_change)
    device.deviceInternal.set_touch_state_callback_configuration(period, value_has_to_change)
end

export get_touch_state_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Touch State Callback Configuration`.
"""
function get_touch_state_callback_configuration(device::BrickletMultiTouchV2)
    return device.deviceInternal.get_touch_state_callback_configuration()
end

export recalibrate
"""
    $(SIGNATURES)

Recalibrates the electrodes. Call this function whenever you changed
or moved you electrodes.
"""
function recalibrate(device::BrickletMultiTouchV2)
    device.deviceInternal.recalibrate()
end

export set_electrode_config
"""
    $(SIGNATURES)

Enables/disables electrodes with a bool array (see :func:`Get Touch State`).

*True* enables the electrode, *false* disables the electrode. A
disabled electrode will always return *false* as its state. If you
don't need all electrodes you can disable the electrodes that are
not needed.

It is recommended that you disable the proximity electrode (element 12) if
the proximity feature is not needed. This will reduce the amount of
traffic that is produced by the :cb:`Touch State` callback.

Disabling electrodes will also reduce power consumption.
"""
function set_electrode_config(device::BrickletMultiTouchV2, enabled_electrodes)
    device.deviceInternal.set_electrode_config(enabled_electrodes)
end

export get_electrode_config
"""
    $(SIGNATURES)

Returns the electrode configuration, as set by :func:`Set Electrode Config`.
"""
function get_electrode_config(device::BrickletMultiTouchV2)
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
function set_electrode_sensitivity(device::BrickletMultiTouchV2, sensitivity)
    device.deviceInternal.set_electrode_sensitivity(sensitivity)
end

export get_electrode_sensitivity
"""
    $(SIGNATURES)

Returns the current sensitivity, as set by :func:`Set Electrode Sensitivity`.
"""
function get_electrode_sensitivity(device::BrickletMultiTouchV2)
    return device.deviceInternal.get_electrode_sensitivity()
end

export set_touch_led_config
"""
    $(SIGNATURES)

Configures the touch LED to be either turned off, turned on, blink in
heartbeat mode or show the touch state (electrode touched = LED on).
"""
function set_touch_led_config(device::BrickletMultiTouchV2, config)
    device.deviceInternal.set_touch_led_config(config)
end

export get_touch_led_config
"""
    $(SIGNATURES)

Returns the LED configuration as set by :func:`Set Touch LED Config`
"""
function get_touch_led_config(device::BrickletMultiTouchV2)
    return device.deviceInternal.get_touch_led_config()
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
function get_spitfp_error_count(device::BrickletMultiTouchV2)
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
function set_bootloader_mode(device::BrickletMultiTouchV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletMultiTouchV2)
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
function set_write_firmware_pointer(device::BrickletMultiTouchV2, pointer)
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
function write_firmware(device::BrickletMultiTouchV2, data)
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
function set_status_led_config(device::BrickletMultiTouchV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletMultiTouchV2)
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
function get_chip_temperature(device::BrickletMultiTouchV2)
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
function reset(device::BrickletMultiTouchV2)
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
function write_uid(device::BrickletMultiTouchV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletMultiTouchV2)
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
function get_identity(device::BrickletMultiTouchV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletMultiTouchV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
