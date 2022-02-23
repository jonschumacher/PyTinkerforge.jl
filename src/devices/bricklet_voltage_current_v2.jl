


export BrickletVoltageCurrentV2CurrentCallbackConfiguration
struct BrickletVoltageCurrentV2CurrentCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletVoltageCurrentV2VoltageCallbackConfiguration
struct BrickletVoltageCurrentV2VoltageCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletVoltageCurrentV2PowerCallbackConfiguration
struct BrickletVoltageCurrentV2PowerCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletVoltageCurrentV2Configuration
struct BrickletVoltageCurrentV2Configuration
    averaging::Integer
    voltage_conversion_time::Integer
    current_conversion_time::Integer
end

export BrickletVoltageCurrentV2Calibration
struct BrickletVoltageCurrentV2Calibration
    voltage_multiplier::Integer
    voltage_divisor::Integer
    current_multiplier::Integer
    current_divisor::Integer
end

export BrickletVoltageCurrentV2SPITFPErrorCount
struct BrickletVoltageCurrentV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletVoltageCurrentV2Identity
struct BrickletVoltageCurrentV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletVoltageCurrentV2
"""
Measures power, DC voltage and DC current up to 720W/36V/20A
"""
mutable struct BrickletVoltageCurrentV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletVoltageCurrentV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_voltage_current_v2")
        deviceInternal = package.BrickletVoltageCurrentV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_current
"""
    $(SIGNATURES)

Returns the current.


If you want to get the value periodically, it is recommended to use the
:cb:`Current` callback. You can set the callback configuration
with :func:`Set Current Callback Configuration`.
"""
function get_current(device::BrickletVoltageCurrentV2)
    return device.deviceInternal.get_current()
end

export set_current_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Current` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Current` callback.

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
function set_current_callback_configuration(device::BrickletVoltageCurrentV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_current_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_current_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Current Callback Configuration`.
"""
function get_current_callback_configuration(device::BrickletVoltageCurrentV2)
    return device.deviceInternal.get_current_callback_configuration()
end

export get_voltage
"""
    $(SIGNATURES)

Returns the voltage.


If you want to get the value periodically, it is recommended to use the
:cb:`Voltage` callback. You can set the callback configuration
with :func:`Set Voltage Callback Configuration`.
"""
function get_voltage(device::BrickletVoltageCurrentV2)
    return device.deviceInternal.get_voltage()
end

export set_voltage_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Voltage` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Voltage` callback.

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
function set_voltage_callback_configuration(device::BrickletVoltageCurrentV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_voltage_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_voltage_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Voltage Callback Configuration`.
"""
function get_voltage_callback_configuration(device::BrickletVoltageCurrentV2)
    return device.deviceInternal.get_voltage_callback_configuration()
end

export get_power
"""
    $(SIGNATURES)

Returns the power.


If you want to get the value periodically, it is recommended to use the
:cb:`Power` callback. You can set the callback configuration
with :func:`Set Power Callback Configuration`.
"""
function get_power(device::BrickletVoltageCurrentV2)
    return device.deviceInternal.get_power()
end

export set_power_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Power` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Power` callback.

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
function set_power_callback_configuration(device::BrickletVoltageCurrentV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_power_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_power_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Power Callback Configuration`.
"""
function get_power_callback_configuration(device::BrickletVoltageCurrentV2)
    return device.deviceInternal.get_power_callback_configuration()
end

export set_configuration
"""
    $(SIGNATURES)

Sets the configuration of the Voltage/Current Bricklet 2.0. It is
possible to configure number of averages as well as
voltage and current conversion time.
"""
function set_configuration(device::BrickletVoltageCurrentV2, averaging, voltage_conversion_time, current_conversion_time)
    device.deviceInternal.set_configuration(averaging, voltage_conversion_time, current_conversion_time)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletVoltageCurrentV2)
    return device.deviceInternal.get_configuration()
end

export set_calibration
"""
    $(SIGNATURES)

Since the ADC and the shunt resistor used for the measurements
are not perfect they need to be calibrated by a multiplier and
a divisor if a very precise reading is needed.

For example, if you are expecting a current of 1000mA and you
are measuring 1023mA, you can calibrate the Voltage/Current Bricklet
by setting the current multiplier to 1000 and the divisor to 1023.
The same applies for the voltage.

The calibration will be saved on the EEPROM of the Voltage/Current
Bricklet and only needs to be done once.
"""
function set_calibration(device::BrickletVoltageCurrentV2, voltage_multiplier, voltage_divisor, current_multiplier, current_divisor)
    device.deviceInternal.set_calibration(voltage_multiplier, voltage_divisor, current_multiplier, current_divisor)
end

export get_calibration
"""
    $(SIGNATURES)

Returns the calibration as set by :func:`Set Calibration`.
"""
function get_calibration(device::BrickletVoltageCurrentV2)
    return device.deviceInternal.get_calibration()
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
function get_spitfp_error_count(device::BrickletVoltageCurrentV2)
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
function set_bootloader_mode(device::BrickletVoltageCurrentV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletVoltageCurrentV2)
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
function set_write_firmware_pointer(device::BrickletVoltageCurrentV2, pointer)
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
function write_firmware(device::BrickletVoltageCurrentV2, data)
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
function set_status_led_config(device::BrickletVoltageCurrentV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletVoltageCurrentV2)
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
function get_chip_temperature(device::BrickletVoltageCurrentV2)
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
function reset(device::BrickletVoltageCurrentV2)
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
function write_uid(device::BrickletVoltageCurrentV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletVoltageCurrentV2)
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
function get_identity(device::BrickletVoltageCurrentV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletVoltageCurrentV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
