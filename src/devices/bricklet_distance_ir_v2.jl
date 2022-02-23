


export BrickletDistanceIRV2DistanceCallbackConfiguration
struct BrickletDistanceIRV2DistanceCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletDistanceIRV2AnalogValueCallbackConfiguration
struct BrickletDistanceIRV2AnalogValueCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletDistanceIRV2SPITFPErrorCount
struct BrickletDistanceIRV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletDistanceIRV2Identity
struct BrickletDistanceIRV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletDistanceIRV2
"""
Measures distance up to 150cm with infrared light
"""
mutable struct BrickletDistanceIRV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletDistanceIRV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_distance_ir_v2")
        deviceInternal = package.BrickletDistanceIRV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_distance
"""
    $(SIGNATURES)

Returns the distance measured by the sensor. Possible
distance ranges are 40 to 300, 100 to 800 and 200 to 1500, depending on the
selected IR sensor.


If you want to get the value periodically, it is recommended to use the
:cb:`Distance` callback. You can set the callback configuration
with :func:`Set Distance Callback Configuration`.
"""
function get_distance(device::BrickletDistanceIRV2)
    return device.deviceInternal.get_distance()
end

export set_distance_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Distance` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Distance` callback.

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
function set_distance_callback_configuration(device::BrickletDistanceIRV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_distance_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_distance_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Distance Callback Configuration`.
"""
function get_distance_callback_configuration(device::BrickletDistanceIRV2)
    return device.deviceInternal.get_distance_callback_configuration()
end

export get_analog_value
"""
    $(SIGNATURES)

Returns the analog value as read by a analog-to-digital converter.

This is unfiltered raw data. We made sure that the integration time
of the ADC is shorter then the measurement interval of the sensor
(10ms vs 16.5ms). So there is no information lost.

If you want to do your own calibration or create your own lookup table
you can use this value.


If you want to get the value periodically, it is recommended to use the
:cb:`Analog Value` callback. You can set the callback configuration
with :func:`Set Analog Value Callback Configuration`.
"""
function get_analog_value(device::BrickletDistanceIRV2)
    return device.deviceInternal.get_analog_value()
end

export set_analog_value_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Analog Value` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Analog Value` callback.

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
function set_analog_value_callback_configuration(device::BrickletDistanceIRV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_analog_value_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_analog_value_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Analog Value Callback Configuration`.
"""
function get_analog_value_callback_configuration(device::BrickletDistanceIRV2)
    return device.deviceInternal.get_analog_value_callback_configuration()
end

export set_moving_average_configuration
"""
    $(SIGNATURES)

Sets the length of a `moving averaging <https://en.wikipedia.org/wiki/Moving_average>`__
for the distance.

Setting the length to 1 will turn the averaging off. With less averaging, there
is more noise on the data.

New data is gathered every ~10ms. With a moving average of length 1000 the
resulting averaging window has a length of approximately 10s. If you want to do
long term measurements the longest moving average will give the cleanest results.
"""
function set_moving_average_configuration(device::BrickletDistanceIRV2, moving_average_length)
    device.deviceInternal.set_moving_average_configuration(moving_average_length)
end

export get_moving_average_configuration
"""
    $(SIGNATURES)

Returns the moving average configuration as set by :func:`Set Moving Average Configuration`.
"""
function get_moving_average_configuration(device::BrickletDistanceIRV2)
    return device.deviceInternal.get_moving_average_configuration()
end

export set_distance_led_config
"""
    $(SIGNATURES)

Configures the distance LED to be either turned off, turned on, blink in
heartbeat mode or show the distance (brighter = object is nearer).
"""
function set_distance_led_config(device::BrickletDistanceIRV2, config)
    device.deviceInternal.set_distance_led_config(config)
end

export get_distance_led_config
"""
    $(SIGNATURES)

Returns the LED configuration as set by :func:`Set Distance LED Config`
"""
function get_distance_led_config(device::BrickletDistanceIRV2)
    return device.deviceInternal.get_distance_led_config()
end

export set_sensor_type
"""
    $(SIGNATURES)

Sets the sensor type.

The Bricklet comes configured with the correct sensor type
and the type is saved in flash (i.e. the Bricklet retains the information if
power is lost).

If you want to change the sensor you can set the type in Brick Viewer,
you will likely never need to call this function from your program.
"""
function set_sensor_type(device::BrickletDistanceIRV2, sensor)
    device.deviceInternal.set_sensor_type(sensor)
end

export get_sensor_type
"""
    $(SIGNATURES)

Returns the sensor type as set by :func:`Set Sensor Type`.
"""
function get_sensor_type(device::BrickletDistanceIRV2)
    return device.deviceInternal.get_sensor_type()
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
function get_spitfp_error_count(device::BrickletDistanceIRV2)
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
function set_bootloader_mode(device::BrickletDistanceIRV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletDistanceIRV2)
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
function set_write_firmware_pointer(device::BrickletDistanceIRV2, pointer)
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
function write_firmware(device::BrickletDistanceIRV2, data)
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
function set_status_led_config(device::BrickletDistanceIRV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletDistanceIRV2)
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
function get_chip_temperature(device::BrickletDistanceIRV2)
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
function reset(device::BrickletDistanceIRV2)
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
function write_uid(device::BrickletDistanceIRV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletDistanceIRV2)
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
function get_identity(device::BrickletDistanceIRV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletDistanceIRV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
