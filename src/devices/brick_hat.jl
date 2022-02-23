


export BrickHATSleepMode
struct BrickHATSleepMode
    power_off_delay::Integer
    power_off_duration::Integer
    raspberry_pi_off::Bool
    bricklets_off::Bool
    enable_sleep_indicator::Bool
end

export BrickHATVoltages
struct BrickHATVoltages
    voltage_usb::Integer
    voltage_dc::Integer
end

export BrickHATVoltagesCallbackConfiguration
struct BrickHATVoltagesCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickHATSPITFPErrorCount
struct BrickHATSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickHATIdentity
struct BrickHATIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickHAT
"""
HAT for Raspberry Pi with 8 Bricklets ports and real-time clock
"""
mutable struct BrickHAT <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickHAT(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.brick_hat")
        deviceInternal = package.BrickHAT(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_sleep_mode
"""
    $(SIGNATURES)

Sets the sleep mode.

.. note::
 Calling this function will cut the Raspberry Pi's power after Power Off Delay seconds.
 You have to shut down the operating system yourself, e.g. by calling 'sudo shutdown -h now'.

Parameters:

* Power Off Delay: Time before the RPi/Bricklets are powered off.
* Power Off Duration: Duration that the RPi/Bricklets stay powered off.
* Raspberry Pi Off: RPi is powered off if set to true.
* Bricklets Off: Bricklets are powered off if set to true.
* Enable Sleep Indicator: If set to true, the status LED will blink in a 1s interval
  during the whole power off duration. This will draw additional 0.3mA.

Example: To turn RPi and Bricklets off in 5 seconds for 10 minutes with sleep
indicator enabled, call (5, 60*10, true, true, true).

This function can also be used to implement a watchdog. To do this you can
write a program that calls this function once per second in a loop with
(10, 2, true, false, false). If the RPi crashes or gets stuck
the HAT will reset the RPi after 10 seconds.
"""
function set_sleep_mode(device::BrickHAT, power_off_delay, power_off_duration, raspberry_pi_off, bricklets_off, enable_sleep_indicator)
    device.deviceInternal.set_sleep_mode(power_off_delay, power_off_duration, raspberry_pi_off, bricklets_off, enable_sleep_indicator)
end

export get_sleep_mode
"""
    $(SIGNATURES)

Returns the sleep mode settings as set by :func:`Set Sleep Mode`.
"""
function get_sleep_mode(device::BrickHAT)
    return device.deviceInternal.get_sleep_mode()
end

export set_bricklet_power
"""
    $(SIGNATURES)

Set to true/false to turn the power supply of the connected Bricklets on/off.
"""
function set_bricklet_power(device::BrickHAT, bricklet_power)
    device.deviceInternal.set_bricklet_power(bricklet_power)
end

export get_bricklet_power
"""
    $(SIGNATURES)

Returns the power status of the connected Bricklets as set by :func:`Set Bricklet Power`.
"""
function get_bricklet_power(device::BrickHAT)
    return device.deviceInternal.get_bricklet_power()
end

export get_voltages
"""
    $(SIGNATURES)

Returns the USB supply voltage and the DC input supply voltage.

There are three possible combinations:

* Only USB connected: The USB supply voltage will be fed back to the
  DC input connector. You will read the USB voltage and a slightly lower
  voltage on the DC input.
* Only DC input connected: The DC voltage will not be fed back to the
  USB connector. You will read the DC input voltage and the USB voltage
  will be 0.
* USB and DC input connected: You will read both voltages. In this case
  the USB supply will be without load, but it will work as backup if you
  disconnect the DC input (or if the DC input voltage falls below the
  USB voltage).
"""
function get_voltages(device::BrickHAT)
    return device.deviceInternal.get_voltages()
end

export set_voltages_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Voltages`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

.. versionadded:: 2.0.1\$nbsp;(Firmware)
"""
function set_voltages_callback_configuration(device::BrickHAT, period, value_has_to_change)
    device.deviceInternal.set_voltages_callback_configuration(period, value_has_to_change)
end

export get_voltages_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Voltages Callback Configuration`.

.. versionadded:: 2.0.1\$nbsp;(Firmware)
"""
function get_voltages_callback_configuration(device::BrickHAT)
    return device.deviceInternal.get_voltages_callback_configuration()
end

export set_rtc_driver
"""
    $(SIGNATURES)

Configures the RTC driver that is given to the Raspberry Pi to be used.
Currently there are two different RTCs used:

* Hardware version <= 1.5: PCF8523
* Hardware version 1.6: DS1338

The correct driver will be set during factory flashing by Tinkerforge.

.. versionadded:: 2.0.3\$nbsp;(Firmware)
"""
function set_rtc_driver(device::BrickHAT, rtc_driver)
    device.deviceInternal.set_rtc_driver(rtc_driver)
end

export get_rtc_driver
"""
    $(SIGNATURES)

Returns the RTC driver as set by :func:`Set RTC Driver`.

.. versionadded:: 2.0.3\$nbsp;(Firmware)
"""
function get_rtc_driver(device::BrickHAT)
    return device.deviceInternal.get_rtc_driver()
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
function get_spitfp_error_count(device::BrickHAT)
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
function set_bootloader_mode(device::BrickHAT, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickHAT)
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
function set_write_firmware_pointer(device::BrickHAT, pointer)
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
function write_firmware(device::BrickHAT, data)
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
function set_status_led_config(device::BrickHAT, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickHAT)
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
function get_chip_temperature(device::BrickHAT)
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
function reset(device::BrickHAT)
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
function write_uid(device::BrickHAT, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickHAT)
    return device.deviceInternal.read_uid()
end

export get_identity
"""
    $(SIGNATURES)

Returns the UID, the UID where the HAT is connected to
(typically '0' as the HAT is the root device in the topology),
the position, the hardware and firmware version as well as the
device identifier.

The HAT (Zero) Brick is always at position 'i'.

The device identifier numbers can be found :ref:`here <device_identifier>`.
|device_identifier_constant|
"""
function get_identity(device::BrickHAT)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickHAT, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
