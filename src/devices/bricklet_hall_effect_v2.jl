


export BrickletHallEffectV2MagneticFluxDensityCallbackConfiguration
struct BrickletHallEffectV2MagneticFluxDensityCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletHallEffectV2CounterConfig
struct BrickletHallEffectV2CounterConfig
    high_threshold::Integer
    low_threshold::Integer
    debounce::Integer
end

export BrickletHallEffectV2CounterCallbackConfiguration
struct BrickletHallEffectV2CounterCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletHallEffectV2SPITFPErrorCount
struct BrickletHallEffectV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletHallEffectV2Identity
struct BrickletHallEffectV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletHallEffectV2
"""
Measures magnetic flux density between -7mT and +7mT
"""
mutable struct BrickletHallEffectV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletHallEffectV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_hall_effect_v2")
        deviceInternal = package.BrickletHallEffectV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_magnetic_flux_density
"""
    $(SIGNATURES)

Returns the `magnetic flux density (magnetic induction) <https://en.wikipedia.org/wiki/Magnetic_flux>`__.


If you want to get the value periodically, it is recommended to use the
:cb:`Magnetic Flux Density` callback. You can set the callback configuration
with :func:`Set Magnetic Flux Density Callback Configuration`.
"""
function get_magnetic_flux_density(device::BrickletHallEffectV2)
    return device.deviceInternal.get_magnetic_flux_density()
end

export set_magnetic_flux_density_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Magnetic Flux Density` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Magnetic Flux Density` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Threshold is turned off"
 "'o'",    "Threshold is triggered when the value is *outside* the min and max values"
 "'i'",    "Threshold is triggered when the value is *inside* or equal to the min and max values"
 "'<'",    "Threshold is triggered when the value is smaller than the min value (max is ignored)"
 "'>'",    "Threshold is triggered when the value is greater than the min value (max is ignored)"

If the option is set to 'x' (threshold turned off) the callback is triggered with the fixed period.
"""
function set_magnetic_flux_density_callback_configuration(device::BrickletHallEffectV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_magnetic_flux_density_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_magnetic_flux_density_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Magnetic Flux Density Callback Configuration`.
"""
function get_magnetic_flux_density_callback_configuration(device::BrickletHallEffectV2)
    return device.deviceInternal.get_magnetic_flux_density_callback_configuration()
end

export get_counter
"""
    $(SIGNATURES)

Returns the current value of the counter.

You can configure the low/high thresholds and the debounce time
with :func:`Set Counter Config`.

If you set reset counter to *true*, the count is set back to 0
directly after it is read.

If you want to get the count periodically, it is recommended to use the
:cb:`Counter` callback. You can set the callback configuration
with :func:`Set Counter Callback Configuration`.
"""
function get_counter(device::BrickletHallEffectV2, reset_counter)
    return device.deviceInternal.get_counter(reset_counter)
end

export set_counter_config
"""
    $(SIGNATURES)

Sets a high and a low threshold as well as a debounce time.

If the measured magnetic flux density goes above the high threshold or
below the low threshold, the count of the counter is increased by 1.

The debounce time is the minimum time between two count increments.
"""
function set_counter_config(device::BrickletHallEffectV2, high_threshold, low_threshold, debounce)
    device.deviceInternal.set_counter_config(high_threshold, low_threshold, debounce)
end

export get_counter_config
"""
    $(SIGNATURES)

Returns the counter config as set by :func:`Set Counter Config`.
"""
function get_counter_config(device::BrickletHallEffectV2)
    return device.deviceInternal.get_counter_config()
end

export set_counter_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Counter`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after at least one of the values has changed. If the values didn't
change within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_counter_callback_configuration(device::BrickletHallEffectV2, period, value_has_to_change)
    device.deviceInternal.set_counter_callback_configuration(period, value_has_to_change)
end

export get_counter_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Counter Callback Configuration`.
"""
function get_counter_callback_configuration(device::BrickletHallEffectV2)
    return device.deviceInternal.get_counter_callback_configuration()
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
function get_spitfp_error_count(device::BrickletHallEffectV2)
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
function set_bootloader_mode(device::BrickletHallEffectV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletHallEffectV2)
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
function set_write_firmware_pointer(device::BrickletHallEffectV2, pointer)
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
function write_firmware(device::BrickletHallEffectV2, data)
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
function set_status_led_config(device::BrickletHallEffectV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletHallEffectV2)
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
function get_chip_temperature(device::BrickletHallEffectV2)
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
function reset(device::BrickletHallEffectV2)
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
function write_uid(device::BrickletHallEffectV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletHallEffectV2)
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
function get_identity(device::BrickletHallEffectV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletHallEffectV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
