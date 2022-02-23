


export BrickletXMC1400BreakoutADCValuesCallbackConfiguration
struct BrickletXMC1400BreakoutADCValuesCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletXMC1400BreakoutCountCallbackConfiguration
struct BrickletXMC1400BreakoutCountCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletXMC1400BreakoutSPITFPErrorCount
struct BrickletXMC1400BreakoutSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletXMC1400BreakoutIdentity
struct BrickletXMC1400BreakoutIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletXMC1400Breakout
"""
Breakout for Infineon XMC1400 microcontroller
"""
mutable struct BrickletXMC1400Breakout <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletXMC1400Breakout(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_xmc1400_breakout")
        deviceInternal = package.BrickletXMC1400Breakout(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_gpio_config
"""
    $(SIGNATURES)

Example for a setter function. The values are the values that can be given to
the XMC_GPIO_Init function. See communication.c in the firmware.
"""
function set_gpio_config(device::BrickletXMC1400Breakout, port, pin, mode, input_hysteresis, output_level)
    device.deviceInternal.set_gpio_config(port, pin, mode, input_hysteresis, output_level)
end

export get_gpio_input
"""
    $(SIGNATURES)

Example for a getter function. Returns the result of a
XMC_GPIO_GetInput call for the given port/pin.
"""
function get_gpio_input(device::BrickletXMC1400Breakout, port, pin)
    return device.deviceInternal.get_gpio_input(port, pin)
end

export set_adc_channel_config
"""
    $(SIGNATURES)

Enables a ADC channel for the ADC driver example (adc.c/adc.h).

There are 8 ADC channels and they correspond to the following pins:

* Channel 0: P2_6
* Channel 1: P2_8
* Channel 2: P2_9
* Channel 3: P2_10
* Channel 4: P2_11
* Channel 5: P2_0
* Channel 6: P2_1
* Channel 7: P2_2
"""
function set_adc_channel_config(device::BrickletXMC1400Breakout, channel, enable)
    device.deviceInternal.set_adc_channel_config(channel, enable)
end

export get_adc_channel_config
"""
    $(SIGNATURES)

Returns the config for the given channel as set by :func:`Set ADC Channel Config`.
"""
function get_adc_channel_config(device::BrickletXMC1400Breakout, channel)
    return device.deviceInternal.get_adc_channel_config(channel)
end

export get_adc_channel_value
"""
    $(SIGNATURES)

Returns the 12-bit value of the given ADC channel of the ADC driver example.
"""
function get_adc_channel_value(device::BrickletXMC1400Breakout, channel)
    return device.deviceInternal.get_adc_channel_value(channel)
end

export get_adc_values
"""
    $(SIGNATURES)

Returns the values for all 8 ADC channels of the adc driver example.

This example function also has a corresponding callback.

See :func:`Set ADC Values Callback Configuration` and :cb:`ADC Values` callback.
"""
function get_adc_values(device::BrickletXMC1400Breakout)
    return device.deviceInternal.get_adc_values()
end

export set_adc_values_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`ADC Values`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_adc_values_callback_configuration(device::BrickletXMC1400Breakout, period, value_has_to_change)
    device.deviceInternal.set_adc_values_callback_configuration(period, value_has_to_change)
end

export get_adc_values_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set ADC Values Callback Configuration`.
"""
function get_adc_values_callback_configuration(device::BrickletXMC1400Breakout)
    return device.deviceInternal.get_adc_values_callback_configuration()
end

export get_count
"""
    $(SIGNATURES)

Returns the value of the example count (see example.c).

This example function uses the "add_callback_value_function"-helper in the
generator. The getter as well as the callback and callback configuration
functions are auto-generated for the API as well as the firmware.


If you want to get the value periodically, it is recommended to use the
:cb:`Count` callback. You can set the callback configuration
with :func:`Set Count Callback Configuration`.
"""
function get_count(device::BrickletXMC1400Breakout)
    return device.deviceInternal.get_count()
end

export set_count_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Count` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Count` callback.

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
function set_count_callback_configuration(device::BrickletXMC1400Breakout, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_count_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_count_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Count Callback Configuration`.
"""
function get_count_callback_configuration(device::BrickletXMC1400Breakout)
    return device.deviceInternal.get_count_callback_configuration()
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
function get_spitfp_error_count(device::BrickletXMC1400Breakout)
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
function set_bootloader_mode(device::BrickletXMC1400Breakout, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletXMC1400Breakout)
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
function set_write_firmware_pointer(device::BrickletXMC1400Breakout, pointer)
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
function write_firmware(device::BrickletXMC1400Breakout, data)
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
function set_status_led_config(device::BrickletXMC1400Breakout, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletXMC1400Breakout)
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
function get_chip_temperature(device::BrickletXMC1400Breakout)
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
function reset(device::BrickletXMC1400Breakout)
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
function write_uid(device::BrickletXMC1400Breakout, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletXMC1400Breakout)
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
function get_identity(device::BrickletXMC1400Breakout)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletXMC1400Breakout, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
